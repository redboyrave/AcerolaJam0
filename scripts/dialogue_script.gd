class_name Dialog
extends Control

##USAGE
##Every time you want to say something,
##You show a instance of this scene;
##Dialog in general is on an array,
##and will proceed in the array order
##

@onready var label: RichTextLabel = $MarginContainer/MarginContainer/RichTextLabel

@export var dialog:PackedStringArray = []
var current_index:int = 0


func start() -> void:
	get_tree().paused = true
	_display_dialog(0)

func _display_dialog(index:int)->void:
	if index > dialog.size()-1 or index < 0:
		return
	label.text = dialog[index]
	current_index = index


func next() -> void:
	_display_dialog(current_index+1)

func previous() -> void:
	_display_dialog(current_index-1)

func stop() -> void:
	if get_tree().paused:
		get_tree().paused = false
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		next()
