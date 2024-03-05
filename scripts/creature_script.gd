class_name Creature
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play(animation:StringName) -> void:
	print(animation_player.get_animation_list())
	if !animation_player.has_animation(animation): return
	animation_player.play(animation)
