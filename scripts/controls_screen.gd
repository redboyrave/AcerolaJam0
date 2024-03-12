extends CanvasLayer

@onready var margin_container: MarginContainer = $MarginContainer
@onready var movement: Label = $MarginContainer/VBoxContainer/Movement
@onready var look: Label = $MarginContainer/VBoxContainer/Look
@onready var crouch: Label = $MarginContainer/VBoxContainer/Crouch
@onready var turn_on: Label = $MarginContainer/VBoxContainer/TurnOn
@onready var take_picture: Label = $MarginContainer/VBoxContainer/TakePicture
@onready var menu: Label = $MarginContainer/VBoxContainer/Menu

var _walked_w:bool = false
var _walked_a:bool = false
var _walked_s:bool = false
var _walked_d:bool = false
var _mouse_move:int = 0
var _joy_look:int = 0
var _crouched:int = 0
var _camera_toggle:int = 0
var _picture:bool = false
var _menu:bool = false

var walk_done:bool
var look_done:bool
var crouch_done:bool
var turn_done:bool
var picture_done:bool
var menu_done:bool

var can_receive:bool = false

func _has_walked() -> void:
	if _walked_w and _walked_a and _walked_s and _walked_d:
		fade_out(movement)
		walk_done = true

func _has_crouched() -> void:
	if _crouched >= 2:
		if crouch_done: return
		fade_out (crouch)
		crouch_done = true

func _has_look() -> void:
	if _mouse_move > 100 or _joy_look>100:
		if look_done: return
		fade_out(look)
		look_done = true

func _has_turn_on() -> void:
	if _camera_toggle >= 2:
		if turn_done: return
		fade_out(turn_on)
		turn_done = true

func _has_picture() -> void:
	if _picture:
		if picture_done: return
		fade_out(take_picture)
		picture_done = true

func _has_menu() -> void:
	if _menu:
		if menu_done: return
		fade_out(menu)
		menu_done = true

func _ready() -> void:
	margin_container.modulate = Color.TRANSPARENT
	await get_tree().create_timer(60).timeout
	fade_out(margin_container)
	var tree_tweens:Array[Tween] = get_tree().get_processed_tweens()
	for tween in tree_tweens:
		await tween.finished
	queue_free()

func _physics_process(_delta: float) -> void:
	if (walk_done
	and look_done
	and crouch_done
	and turn_done
	and picture_done
	and menu_done):
		if is_queued_for_deletion(): return
		await get_tree().create_timer(.25).timeout
		var tree_tweens:Array[Tween] = get_tree().get_processed_tweens()
		for tween in tree_tweens:
			await tween.finished
		queue_free()

func fade_in() -> void:
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(margin_container,"modulate",Color.WHITE,.5)
	await tween.finished
	can_receive = true

func fade_out(node:Control) -> void:
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(node,"modulate",Color.TRANSPARENT,1)
	tween.play()

func _input(event: InputEvent) -> void:
	if !can_receive: return
	if event.is_action_pressed("ctrl_crouch"):
		_crouched += 1
	if event.is_action_pressed("ctrl_up") or event.get_action_strength("ctrl_up")>.1:
		_walked_w = true
	if event.is_action_pressed("ctrl_left") or event.get_action_strength("ctrl_left")>.1:
		_walked_a = true
	if event.is_action_pressed("ctrl_down") or event.get_action_strength("ctrl_down")>.1:
		_walked_s = true
	if event.is_action_pressed("ctrl_right") or event.get_action_strength("ctrl_right")>.1:
		_walked_d = true
	if event.is_action_pressed("ctrl_toggle_camera") or event.get_action_strength("ctrl_joy_toggle_camera")>.25:
		_camera_toggle += 1;
	if event.is_action_pressed("ctrl_photograph") or event.get_action_strength("ctrl_joy_photograph")>.25:
		_picture = true
	if event.is_action_pressed("ctrl_menu"):
		_menu = true
	if event is InputEventMouseMotion:
		_mouse_move +=1
	if (event.get_action_strength("ctrl_look_up")>.1
	or event.get_action_strength("ctrl_look_left")>.1
	or event.get_action_strength("ctrl_look_down")>.1
	or event.get_action_strength("ctrl_look_right")>.1):
		_joy_look += 1

	_has_walked()
	_has_look()
	_has_crouched()
	_has_turn_on()
	_has_picture()
	_has_menu()
