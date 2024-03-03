extends Control

@onready var animation_player:AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("Splash")
	await animation_player.animation_finished
	temp_quit()

func _input(event):
	if event.is_pressed():
		##Skip
		temp_quit()


func temp_quit():
	get_tree().quit()
