extends CanvasLayer

@onready var play: Button = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Play
@onready var settings: Button = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Settings
@onready var about: Button = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/About
@onready var exit: Button = $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Exit

const SETTINGS:PackedScene = preload("res://scenes/settings/settings.tscn")
const QUIT_POPUP = preload("res://scenes/pause/quit_popup.tscn")

func _ready()->void:
	play.grab_focus()
	GameManager.is_menu = true

func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	var instance:CanvasLayer = SETTINGS.instantiate()
	get_tree().root.add_child(instance)


func _on_about_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	var instance:Popup = QUIT_POPUP.instantiate()
	get_tree().root.add_child(instance)
