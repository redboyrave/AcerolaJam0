@tool
class_name Dialog
extends Control

##USAGE
##Every time you want to say something,
##You show a instance of this scene;
##Dialog in general is on an array,
##and will proceed in the array order
##

@onready var label: RichTextLabel = $MarginContainer/MarginContainer/RichTextLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_index:int = 0
@export var dialogue:Array[String] = []

signal finished

func start() -> void:
	GameManager.pause()
	show()
	_display_dialog(0)
	animation_player.play("Arrow")


func _display_dialog(index:int)->void:
	if index < 0:
		return
	if index > (dialogue.size()-1):
		stop()
		return
	label.text = dialogue[index]
	current_index = index


func next() -> void:
	_display_dialog(current_index+1)

func previous() -> void:
	_display_dialog(current_index-1)

func stop() -> void:
	hide()
	if GameManager.paused:
		GameManager.unpause()
	finished.emit()
	queue_free()

func _input(event: InputEvent) -> void:
	if GameManager.paused and event.is_action_pressed("ctrl_interact"):
		next()
