extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_animator: AnimationPlayer = $ArrowAnimator

var cutscene_end:bool = false
const FIRST_SCENE_V_2 = preload("res://scenes/first_scene_v2.tscn")


func _ready() -> void:
	await get_tree().create_timer(.5).timeout ##delay
	GameManager.capture_mouse()
	animation_player.play("fade_in")

func _unhandled_input(event: InputEvent) -> void:
	if animation_player.current_animation == "fade_out": return
	if event.is_pressed() and animation_player.is_playing():
		animation_player.seek(animation_player.current_animation_length,true)
		animation_player.animation_finished.emit("fade_in")
		get_viewport().set_input_as_handled()
		return
	if event.is_pressed() and cutscene_end:
		animation_player.play("fade_out")
		get_viewport().set_input_as_handled()

		return

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if !anim_name == "fade_in": return
	$Color/Control/Arrow.visible = true
	arrow_animator.play("Arrow")
	cutscene_end= true
	return

func load_level()->void:
	var instance:Node3D = FIRST_SCENE_V_2.instantiate()
	get_tree().root.add_child(instance)
