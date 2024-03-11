extends HBoxContainer

@export_enum("Master","Music","SFX","Voice") var sound_channel:String

@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit

var bus_index:int
var prop:String

var volume:float :
	set(value):
		volume = value
		if !is_node_ready(): await ready
		SaveManager.preferences.set(prop,value)
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(volume/100))

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(sound_channel)
	prop = get_save_property()
	var value:float = db_to_linear(AudioServer.get_bus_volume_db(bus_index)) * 100
	h_slider.value = value
	line_edit.text = "%.2f" %value

func _on_h_slider_value_changed(value: float) -> void:
	line_edit.text = "%.2f" %value
	volume = value

func _on_line_edit_text_submitted(new_text: String) -> void:
	if !new_text.is_valid_float():
		line_edit.text = "%.2f" %h_slider.value
	volume = new_text.to_float()
	h_slider.value = volume


func get_save_property() -> String:
	match sound_channel:
		"Master":
			return "master_volume"
		"Music":
			return "music_volume"
		"SFX":
			return "sfx_volume"
		"Voice":
			return "voice_volume"
	return ""
