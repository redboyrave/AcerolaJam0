extends Area3D


signal trigger_1

var triggered:bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready()->void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if triggered: return
	if !body is Player:
		return
	emit_signal("trigger_1")
	triggered = true
	var p:Player = body as Player
	p.can_move = false
	animation_player.play("Cutscene1")
	await  animation_player.animation_finished
	p.can_move = true
	queue_free()
