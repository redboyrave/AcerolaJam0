class_name PictureIcon
extends AspectRatioContainer

@export var picture:Texture : set= set_picture
var disabled:bool = false : set= set_disabled

signal button_pressed(button:PictureIcon)

func set_picture(value:Texture) -> void:
	picture= value
	$Button/MarginContainer/TextureRect.texture = picture

func set_disabled(value:bool) -> void:
	disabled = value
	$Button.disabled = disabled
	var p:Texture = picture
	if disabled: p = null
	$Button/MarginContainer/TextureRect.texture = p



func _on_button_pressed() -> void:
	button_pressed.emit(self)

