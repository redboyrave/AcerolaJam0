extends CanvasLayer

const ABOUT_SCREEN = preload("res://scenes/about_screen.tscn")
const MENU = preload("res://scenes/menu.tscn")


@onready var label: Label = $ColorRect/VBoxContainer/HBoxContainer/Label

func _ready() -> void:
	GameManager.is_menu = true
	GameManager.free_mouse()
	fade_in()
	var _about:CanvasLayer = ABOUT_SCREEN.instantiate()
	await get_tree().create_timer(5).timeout
	add_child(_about)
	if !_about.is_node_ready() : await _about.ready
	_about.get_node("Panel/Button").pressed.connect(_on_exit)

func _on_exit() -> void:
	get_tree().root.add_child(MENU.instantiate())

func fade_in() -> void:
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(label,"modulate",Color.WHITE,.5)
