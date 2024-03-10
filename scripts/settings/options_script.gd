class_name OptionsDropDown
extends HBoxContainer

@onready var option_button: OptionButton = $OptionButton
@onready var label: Label = $Label


@export var text:String:
	set(value):
		text=value
		if !is_node_ready(): await ready
		label.text = text

@export var options: Array[String] = [] :set = _set_options


func _set_options(value:Array[String])->void:
	options = value

func _ready()->void:
	populate_options()

func populate_options()->void:
	option_button.clear()
	for item in options:
		option_button.add_item(item)

func _on_button_item_selected(index: int) -> void:
	print(options[index])
