class_name BigPicture
extends Control

@export var picture:Texture :
	set(value):
		picture=value
		$ColorRect2/MarginContainer/TextureRect.texture = picture
