extends Control



var options:Array[Vector2i] = []
var window_size:Vector2i
var window_ratio:float

var render_resolution:Vector2i

@onready var option_button: OptionButton = $HBoxContainer/OptionButton
@onready var popup_panel: PopupPanel = $HBoxContainer/PopupPanel

func populate_buttons() -> void:
	option_button.clear()
	for i:int in range(options.size()):
		var entry:Vector2i = options[i]
		var str_value:String = "%d x %d" %[entry.x,entry.y]
		option_button.add_item(str_value,i)


func _ready() -> void:
	render_resolution = Vector2i(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"))
	get_window().size_changed.connect(_on_window_size_change)
	window_size = get_window().size
	window_ratio = float(window_size.x)/window_size.y
	options.append(render_resolution)
	calculate_sizes()
	option_button.selected = options.find(window_size)


func _on_window_size_change() -> void:
	var new_size:Vector2i = get_window().size
	if window_size == new_size: return
	window_size = new_size
	window_ratio = float(window_size.x)/window_size.y
	calculate_sizes()


func calculate_sizes() -> void:
	options.clear()
	options.append(render_resolution)
	for i in range(1,6):
		var value:int = 360*i
		var vector:Vector2i = Vector2i(round(value*(window_ratio)),value)
		if options.has(vector): continue
		options.append(vector)
	options.append_array(SaveManager.preferences.custom_window_sizes)
	options.sort()
	print(options)
	populate_buttons()



func _on_popup_panel_custom_size(new_size: Vector2i) -> void:
	SaveManager.preferences.custom_window_sizes.append(new_size)

func _on_button_pressed() -> void:
	popup_panel.show()

func _on_option_button_item_selected(index: int) -> void:
	window_size = options[index]
	SaveManager.preferences.window_size = options[index]
	get_window().size = options[index]


