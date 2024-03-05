extends Node



func _ready() -> void:
	$Wind.play()


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
