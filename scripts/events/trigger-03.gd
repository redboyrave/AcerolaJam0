extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var triggered:bool = false

func _on_body_entered(body: Node3D) -> void:
	if triggered: return
	if !body is Player: return
	GameManager.pause()
	animation_player.play()
	await animation_player.animation_finished
	GameManager.unpause()
