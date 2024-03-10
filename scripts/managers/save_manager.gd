extends Node

var preference_path:String = "user://user_preferences.save" ##REMEMBER TO CHANGE TO USER / NOT RES
var preferences:PlayerPreferences

func _ready() -> void:
	load_preferences()
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
