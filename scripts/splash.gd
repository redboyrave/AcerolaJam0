extends Control

@onready var animation_player:AnimationPlayer = $AnimationPlayer
const MENU = preload("res://scenes/menu.tscn")

var _menu:Node

func _ready() -> void:
	AudioManager.stop_all()
	_menu = MENU.instantiate()
	animation_player.play("Splash")
	await animation_player.animation_finished
	get_tree().root.add_child(_menu)
	queue_free()

func _input(event) -> void:
	if event.is_pressed():
		##Skip
		await fade_to_black()
		get_tree().root.add_child(_menu)

func fade_to_black() -> void:
	var tween:Tween = get_tree().create_tween()
	$ColorRect2
	tween.tween_property($ColorRect2,"modulate",Color.WHITE,.5)
	await tween.finished
	queue_free()
