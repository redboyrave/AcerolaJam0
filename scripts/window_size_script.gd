extends OptionsDropDown


var options_dict:Dictionary = {}

func _on_button_item_selected(index: int) -> void:
	SaveManager.preferences.window_size = options[index]
	DisplayServer.window_set_size(options_dict[options[index]])

func _set_options(value:Array[String]) -> void:
	options = value
	## I'm expecting it to be int x int
	for option in options:
		var dimension:PackedStringArray = option.rsplit("x")
		var int_vector2 :Vector2i= Vector2i(dimension[0].to_int(),dimension[1].to_int())
		options_dict[option] = int_vector2

func _ready() -> void:
	populate_options()
	var current:Vector2i = get_window().size
	var select_index:int = options.find(options_dict.find_key(current))
	option_button.select(select_index)

