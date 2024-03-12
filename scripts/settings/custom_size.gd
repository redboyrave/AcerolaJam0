extends PopupPanel

signal custom_size(size:Vector2i)

@onready var width_edit: LineEdit = $MarginContainer/VBoxContainer/GridContainer/WidthEdit
@onready var height_edit: LineEdit = $MarginContainer/VBoxContainer/GridContainer/HeightEdit

var width:int
var height:int

func _on_width_edit_text_changed(new_text: String) -> void:
	var digits:String = get_digits_only(new_text)
	for letter in new_text:
		if letter.is_valid_int():
			digits += letter
	width_edit.text = digits
	width = digits.to_int()


func _on_height_edit_text_changed(new_text: String) -> void:
	var digits:String = get_digits_only(new_text)
	width_edit.text = digits
	height = digits.to_int()

func get_digits_only(text:String) ->String:
	var digits:String = ""
	for letter:String in text:
		if letter.is_valid_int():
			digits += letter
	return digits

func _on_button_pressed() -> void:
	custom_size.emit(Vector2i(width,height))
	width_edit.text = ""
	height_edit.text = ""
	hide()
