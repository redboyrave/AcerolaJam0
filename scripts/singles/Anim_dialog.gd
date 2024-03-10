extends Node

@export var text:Array[String]
func dialog() -> void:
	GameManager.dialog(text)
