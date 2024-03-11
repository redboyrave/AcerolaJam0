extends OptionsDropDown


func _ready() -> void:
	populate_options()


func _on_button_item_selected(index: int) -> void:
	var value:int = options[index].to_int()
	ProjectSettings.set_setting("display/window/size/viewport_height",value)

	print(options[index])
