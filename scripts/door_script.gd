class_name Door
extends AnimatableBody3D

var is_open:bool = false


func interact(_origin:Node3D)->void:
	var tween:Tween = get_tree().create_tween()
	var final_rotation:float = 0 if is_open else -100
	is_open = !is_open
	tween.tween_property(self,"rotation_degrees:y", final_rotation,.1)
	tween.play()
