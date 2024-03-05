extends Area3D


signal trigger_1

var triggered:bool = false

func _ready():
	pass

func _on_body_entered(body: Node3D) -> void:
	if triggered: return
	if !body is Player:
		return
	emit_signal("trigger_1")
	triggered = true
