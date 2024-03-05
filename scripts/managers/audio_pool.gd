@tool
class_name AudioPool
extends Node

var sound_ammount:int
var last_played_sound:int
var audio_queues:Array[AudioQueue] = []


@export_range(0,100) var audio_volume:float = 100 : set=set_volume;
var audio_bus:String = "Master"

func set_volume(value:float)->void:
	audio_volume = clamp(value,0,100)
	for audio in audio_queues:
		audio.volume = (audio.volume * (audio_volume))/100

func _get_property_list() -> Array[Dictionary]:
	var properties:Array[Dictionary] = []
	#{ "name": "bus",
	#"class_name": &"",
	#"type": 21,
	# "hint": 2,
	#"hint_string": "Master,Music,SFX,Voice",
	#"usage": 6 },
	var options:String = ""
	for i in AudioServer.bus_count:
		options += AudioServer.get_bus_name(i) + ","
	properties.append(
		{
			name = "audio_bus",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_ENUM,
			hint_string = options,
			usage = PROPERTY_USAGE_STORAGE + PROPERTY_USAGE_EDITOR,
		}
	)
	return properties


func _ready() -> void:
	for child in get_children():
		if !child is AudioQueue:
			push_warning("child is not an audio queue")
			continue
		audio_queues.append(child)
		child.audio_bus = audio_bus
	sound_ammount = get_child_count()
	set_volume(audio_volume)


func play() -> void:
	var rand:int = randi() % sound_ammount
	## should worry about not repeating?
	while rand == last_played_sound:
		rand = randi() % sound_ammount
	audio_queues[rand].play()
	last_played_sound = rand

func stop() -> void:
	for audio in audio_queues:
		audio.stop()


func _get_configuration_warnings() -> PackedStringArray:
	var warning:PackedStringArray = []
	if get_child_count() == 0:
		warning.append("Requires at least one child")
	for child in get_children():
		if !child is AudioQueue:
			warning.append("%s is not an AudioQueue" %child.name)
	return warning
