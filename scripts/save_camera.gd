extends Camera3D

func _process(delta: float) -> void:
	global_transform = $"../..".global_transform
