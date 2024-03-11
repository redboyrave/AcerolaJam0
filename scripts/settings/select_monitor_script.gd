extends OptionsDropDown

signal screen_changed(index:int)


func _ready() -> void:
	populate_options()
	var current:int = DisplayServer.window_get_current_screen()
	option_button.select(current)

func populate_options()->void:
	option_button.clear()
	for i in DisplayServer.get_screen_count():
		option_button.add_item("Screen %s" %(i+1),i)

func _on_button_item_selected(index: int) -> void:
	SaveManager.preferences.prefered_monitor = index
	emit_signal("screen_changed",index)


