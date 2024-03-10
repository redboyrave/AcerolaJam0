extends Area3D

@export var cutscene_text:Array[String] = []

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var creature: Creature = $Creature

var trigerred:bool = false


func _ready() -> void:
	creature.play("jump_hold",0.1)




func _on_body_entered(body: Node3D) -> void:
	if trigerred: return
	if !body is Player: return
	GameManager.pause()
	animation_player.play("Cutscene2")
	## DO CUTSCENE THINGS ##
	await animation_player.animation_finished
	trigerred = true
	GameManager.unpause()
	GameManager.dialog(cutscene_text)
