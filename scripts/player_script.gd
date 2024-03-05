class_name Player
extends CharacterBody3D

@export var walk_speed:float = 2.0
@export var crouch_speed:float = 1.0
@export var step_sound_time:float = 1 :
	set(value):
		step_sound_time = value;
		if !timer: timer = $Timer
		timer.wait_time = step_sound_time
@export var standing_height:float = 1.75
@export var crouch_height:float = 1.0
@export var jump_height:float = 1.0
@export var jump_time:float = 2.0
@export_range(0.05,.15) var camera_distance_from_top:float = .10
@export var arm_length:float = 1.5 :set = set_arm_length

@onready var _gravity:Vector3 = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")
@onready var _jump_speed:float = calculate_jump_speed(jump_height,jump_time)
@onready var camera_node:HeroCamera = $Camera3D/Camera
@onready var animation_player:AnimationPlayer = $Camera3D/AnimationPlayer
@onready var timer:Timer = $Timer
@onready var arm_raycast:RayCast3D = $Camera3D/RayCast3D


var can_move:bool = true
var current_velocity:Vector3
var is_crouched:bool = false : set=set_crouch

func calculate_movement() -> Vector2:
	var input:Vector2 = Input.get_vector("ctrl_left","ctrl_right","ctrl_up","ctrl_down")
	return input * (crouch_speed if is_crouched else walk_speed)

func calculate_jump_speed(height:float,time:float) -> float:
	return (height * 2) / (time*0.5)

func set_crouch(value:bool) -> void:
	is_crouched = value
	var capsule:CollisionShape3D = $Capsule
	var tween:Tween = get_tree().create_tween()
	var height:float = standing_height if !is_crouched else crouch_height
	tween.tween_property(capsule.shape,"height", height, .1)
	tween.tween_property($Camera3D,"position:y",height-camera_distance_from_top,.1)
	tween.set_parallel(true)
	tween.play()
	#$Camera3D.position.y = capsule.shape.height - camera_distance_from_top

func set_arm_length(value:float) -> void:
	arm_length = value
	if arm_raycast:
		arm_raycast.target_position = Vector3.FORWARD * arm_length


func crouch_toggle() -> void:
	is_crouched = !is_crouched

func _ready() -> void:
	animation_player.play_backwards("Toggle Camera")
	animation_player.seek(0)
	set_arm_length(arm_length)

func _physics_process(delta:float) -> void:
	var input:Vector2 = calculate_movement()

	var tranformed_input:Vector3 = global_transform.basis * Vector3(input.x,0,input.y)
	if can_move:
		current_velocity = Vector3(tranformed_input.x,current_velocity.y,tranformed_input.z)
	else:
		current_velocity = Vector3(0,current_velocity.y,0)
	if is_on_floor():
		current_velocity.y = 0
		if !input.is_zero_approx() and timer.is_stopped():
			timer.start()
		if input.is_zero_approx():
			timer.stop()
		if Input.is_action_just_pressed("ctrl_jump"):
			current_velocity.y += _jump_speed
	else:
		current_velocity += _gravity*delta
	velocity = current_velocity
	move_and_slide()


func _unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("ctrl_crouch"):
		get_viewport().set_input_as_handled()
		crouch_toggle()
	if event.is_action_pressed("ctrl_toggle_camera"):
		camera_node.toggle_camera()
		get_viewport().set_input_as_handled()
		animate_camera()
	if event.is_action_pressed("ctrl_photograph"):
		take_picture()
	if event.is_action_pressed("ctrl_interact"):
		get_viewport().set_input_as_handled()
		if camera_node.is_camera_on:
			return
		interact()

func animate_camera() -> void:
	var play_direction:StringName = "play"
	var t:float = 0
	if !camera_node.is_camera_on:
		play_direction = "play_backwards"
		t = 1
	if animation_player.is_playing():
		t = animation_player.get_current_animation_position()
	animation_player.call(play_direction,"Toggle Camera")
	animation_player.seek(t)

func interact() -> void:
	if !arm_raycast.is_colliding():
		return

	var collider:Node3D = arm_raycast.get_collider()
	if collider.has_method("interact"):
		print("interacting with %s" %collider.name)
		collider.call("interact",self)


func take_picture() ->void:
	camera_node.take_picture()

func _on_timer_timeout() -> void:
	AudioManager.play("Steps")
	pass # Replace with function body.
