extends Node

var preference_path:String = "user://user_preferences.save" ##REMEMBER TO CHANGE TO USER / NOT RES
var preferences:PlayerPreferences

func _ready() -> void:
	load_preferences()
	apply_preferences()
	tree_exiting.connect(_on_tree_exiting)

func load_preferences()->void:
	preferences = PlayerPreferences.new()
	if !FileAccess.file_exists(preference_path):
		print("creating new preference file")
		save_preferences()
	var file:FileAccess = FileAccess.open(preference_path,FileAccess.READ)
	var dict:Dictionary = JSON.parse_string(file.get_as_text())
	for i:String in dict:
		if preferences.get(i):
			preferences.set(i,dict[i])

func save_preferences()->void:
	var file:FileAccess = FileAccess.open(preference_path,FileAccess.WRITE_READ)
	var pref_dict:String = preferences_to_json()
	file.store_line(pref_dict)
	file.close()

func preferences_to_json()->String:
	var dict:Dictionary = {}
	var properties:Array = preferences.get_script().get_script_property_list()
	for prop:Dictionary in properties:
		var value:Variant = preferences.get(prop.name)
		if value != null:
			dict[prop.name] = value
	var json:String = JSON.stringify(dict)
	return json

func _on_tree_exiting() -> void:
	save_preferences()

func apply_preferences()-> void:
	## window settings
	if !preferences.window_mode : preferences.window_mode = 1
	match preferences.window_mode:
		0: ##Full Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		1: ##Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,false)
		2: ##Borderless Full Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)
		3: ## Borderless Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,true)

	if !preferences.window_size: preferences.window_size = Vector2i(1280,720)
	get_window().size = preferences.window_size
	var vsync:int = DisplayServer.VSYNC_ENABLED if preferences.v_sync else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(vsync)

	## audio settings
	var master_index:int  = AudioServer.get_bus_index("Master")
	var music_index:int  = AudioServer.get_bus_index("Music")
	var sfx_index:int  = AudioServer.get_bus_index("SFX")
	var voice_index:int = AudioServer.get_bus_index("Voice")

	AudioServer.set_bus_volume_db(master_index,linear_to_db(preferences.master_volume/100))
	AudioServer.set_bus_volume_db(music_index,linear_to_db(preferences.music_volume/100))
	AudioServer.set_bus_volume_db(sfx_index,linear_to_db(preferences.sfx_volume/100))
	AudioServer.set_bus_volume_db(voice_index,linear_to_db(preferences.voice_volume/100))
