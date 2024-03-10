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

var is_active:bool :
	set(value):
		is_active = value
		visible = is_active

func start() -> void:
	GameManager.pause()
	is_active = true
	_display_dialog(0)
	animation_player.play("Arrow")

func stop() -> void:
	is_active = false
	finished.emit()

func _display_dialog(index:int)->void:
	if !is_active: return
	if index < 0:
		return
	if index > (dialogue.size()-1):
		stop()
		return
	label.text = dialogue[index]
	current_index = index


func next() -> void:
	if !is_active: return
	_display_dialog(current_index+1)

func previous() -> void:
	if !is_active: return
	_display_dialog(current_index-1)

func _input(event: InputEvent) -> void:
	if GameManager.paused and event.is_action_pressed("ctrl_interact"):
		if !visible:return
		get_viewport().set_input_as_handled()
		next()
