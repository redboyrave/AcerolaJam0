class_name Creature
extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play(animation:StringName, speed:float = 1) -> void:
	if !animation_player.has_animation(animation): return
	animation_player.play(animation)
	animation_player.speed_scale = speed
	await animation_player.animation_finished
	animation_player.speed_scale = 1
