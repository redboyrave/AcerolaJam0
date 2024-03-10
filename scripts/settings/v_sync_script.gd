extends HBoxContainer

@onready var check_button: CheckButton = $CheckButton

func _ready()->void:
	if DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED:
		check_button.button_pressed = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	var mode:int = DisplayServer.VSYNC_DISABLED
	if toggled_on: mode = DisplayServer.VSYNC_ENABLED
	DisplayServer.window_set_vsync_mode(mode)
	SaveManager.preferences.v_sync = toggled_on

