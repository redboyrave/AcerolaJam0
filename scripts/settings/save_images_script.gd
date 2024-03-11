extends HBoxContainer

@onready var check_button: CheckButton = $CheckButton
@onready var save_location: HBoxContainer = $"../Save Location"

func _ready() -> void:
	check_button.button_pressed = SaveManager.preferences.save_picture

func _on_check_button_toggled(toggled_on: bool) -> void:
	SaveManager.preferences.save_picture = toggled_on
	save_location.visible = toggled_on
