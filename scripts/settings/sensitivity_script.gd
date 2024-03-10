extends HBoxContainer

@export_enum("mouse_sensitivity", "joy_sensitivity") var sensitivity:String;
@onready var h_slider: HSlider = get_node("HBoxContainer/HSlider")
@onready var line_edit: LineEdit = get_node("HBoxContainer/LineEdit")

var text_value:String :
	set(value):
		text_value = value
		SaveManager.preferences.set(sensitivity,text_value.to_float())


func _ready() -> void:
	var sens_value:float = SaveManager.preferences.get(sensitivity)
	h_slider.value = sens_value
	line_edit.text = "%.2f" %sens_value
	text_value = line_edit.text



func _on_line_edit_text_submitted(new_text: String) -> void:
	if !new_text.is_valid_float():
		line_edit.text = text_value
		return
	text_value = "%.2f" %new_text.to_float()
	line_edit.text = text_value
	h_slider.value = new_text.to_float()


func _on_h_slider_value_changed(value: float) -> void:
	text_value = "%.2f" %value
	line_edit.text = text_value
