extends Marker3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("part1")
	GameManager.is_menu = true
	GameManager.pause()
	GameManager.capture_mouse()




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "part1":
		GameManager.dialog(["I'm finally here...","I can't believe it..."],true)
		await GameManager.dialog_scene.finished
		animation_player.play("part2")
		return
	if anim_name == "part2":
		GameManager.dialog(["Ouch...", "Wait, is the camera ok?"])
		await GameManager.dialog_scene.finished
		animation_player.play("part3")
		return
	if anim_name == "part3":
		GameManager.unpause()
		GameManager.is_menu = false

