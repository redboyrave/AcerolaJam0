extends GridContainer

@onready var mouse_x: HBoxContainer = $MouseX
@onready var controller_x: HBoxContainer = $"ControllerX"
@onready var mouse_y: HBoxContainer = $MouseY
@onready var controller_y: HBoxContainer = $"ControllerY"


func _ready() -> void:
	mouse_x.get_node("CheckButton").button_pressed = SaveManager.preferences.mouse_invert_x
	mouse_y.get_node("CheckButton").button_pressed = SaveManager.preferences.mouse_invert_y
	controller_x.get_node("CheckButton").button_pressed = SaveManager.preferences.joy_invert_x
	controller_y.get_node("CheckButton").button_pressed = SaveManager.preferences.joy_invert_y

func _on_mouse_x_button_toggled(toggled_on: bool) -> void:
	SaveManager.preferences.mouse_invert_x = toggled_on

func _on_mouse_y_button_toggled(toggled_on: bool) -> void:
	SaveManager.preferences.mouse_invert_y = toggled_on

func _on_joy_x_button_toggled(toggled_on: bool) -> void:
	SaveManager.preferences.joy_invert_x = toggled_on

func _on_joy_y_button_toggled(toggled_on: bool) -> void:
	SaveManager.preferences.joy_invert_x = toggled_on


