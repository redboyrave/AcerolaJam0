extends OptionsDropDown


func _ready() -> void:
	populate_options()
	var mode:int = DisplayServer.window_get_mode(0)
	var borderless:bool = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	var opt:int = 0
	if mode == DisplayServer.WINDOW_MODE_WINDOWED:
		opt += 1
	if borderless:
		opt +=1
	if !option_button.is_node_ready(): await option_button.ready
	option_button.select(opt)

func _on_button_item_selected(index: int) -> void:
	SaveManager.preferences.window_mode = index
	match index:
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
