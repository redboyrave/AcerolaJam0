class_name BigPicture
extends Control


@onready var texture_rect: TextureRect = $Frame1/MarginContainer/TextureRect

@export var picture:Texture :
	set(value):
		picture=value
		texture_rect.texture = picture
