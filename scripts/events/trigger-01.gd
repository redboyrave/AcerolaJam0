extends Area3D


var triggered:bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node3D) -> void:
	if triggered: return
	if !body is Player:
		return
	GameManager.pause()
	triggered = true
	animation_player.play("Cutscene1")


func _on_dialog_finished() -> void:
	queue_free()
