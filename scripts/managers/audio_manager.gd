extends Node


@export var audio_volume:float = 100:
	set(value):
		audio_volume = value
		AudioServer.set_bus_volume_db(0,linear_to_db(audio_volume / 100))



func _ready() -> void:
	$Wind.play()
	$Leaves.play()


func play(audio:StringName) -> void:
	var i:int = -1
	for n in range(get_child_count()):
		var child:Node = get_child(n)
		if !(child is AudioPool or child is AudioQueue):
			continue
		if child.name.to_lower() == audio.to_lower():
			i = n
			break
	if i < 0:
		return
	get_child(i).play()
