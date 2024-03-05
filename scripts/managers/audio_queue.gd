@tool
class_name AudioQueue
extends Node

@export_range(0,100) var volume:float = 100 : set=set_volume;
@export var audio_players_ammount:int = 5;
@export var audio_stream:AudioStream;
@export_node_path("AudioStreamPlayer") var player_path:NodePath

var audio_player:AudioStreamPlayer

var audio_bus:String = "Master": set = set_audio_bus

func _get_property_list() -> Array[Dictionary]:
	var property:Array[Dictionary] = []
	var options:String = ""
	for i in AudioServer.bus_count:
		options += AudioServer.get_bus_name(i) + ","
	property.append(		{
			name = "audio_bus",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_ENUM,
			hint_string = options,
			usage = PROPERTY_USAGE_STORAGE + PROPERTY_USAGE_EDITOR,
		})
	return property

func set_audio_bus(value:String)->void:
	audio_bus = value
	if audio_player:
		audio_player.bus = audio_bus

func set_volume(value:float)->void:
	volume = clamp(value,0,100)
	if audio_player:
		audio_player.volume_db = linear_to_db(volume/100)

func _ready() ->void:
	audio_player = get_node(player_path)
	if !audio_player:
		push_warning("no audio player")
		return
	if !audio_stream:
		push_warning("no audio set")
		return
	audio_player.stream = audio_stream;
	audio_player.max_polyphony = audio_players_ammount
	#players.append(audio_player)
	#for i in range(1,audio_players_ammount):
		#var dupe:AudioStreamPlayer = audio_player.duplicate()
		#add_child(dupe)
		#players.append(dupe)
	set_volume(volume)
	set_audio_bus(audio_bus)

func play() -> void:
	audio_player.play()
	return

func _get_configuration_warnings() -> PackedStringArray:
	var warning:PackedStringArray = []
	if !get_children()[0]:
		warning.append("Requires a child")
	elif !(get_children()[0] is AudioStreamPlayer):
		warning.append("The child needs to be an AudioStreamPlayer")
	if self.get_children().size() != 1 :
		warning.append("Only one child is allowed")
	return(warning)

