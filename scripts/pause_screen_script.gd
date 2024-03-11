extends CanvasLayer

@export_node_path("GridContainer") var grid_container_path:NodePath
@export_node_path("Control") var black_fade_path:NodePath
@export_node_path("Control") var big_picture_path:NodePath
@export_node_path("AnimationPlayer") var animation_player_path:NodePath

@export_node_path("Button") var continue_button_path:NodePath
@export_node_path("Button") var settings_button_path:NodePath
@export_node_path("Button") var exit_button_path:NodePath

@onready var grid_container: GridContainer =get_node(grid_container_path)
@onready var black_fade: Control = get_node(black_fade_path)
@onready var big_picture: BigPicture = get_node(big_picture_path)
@onready var animation_player: AnimationPlayer = get_node(animation_player_path)

@onready var continue_button:Button = get_node(continue_button_path)
@onready var settings_button:Button = get_node(settings_button_path)
@onready var exit_button:Button = get_node(exit_button_path)

const grid_columns:int = 4

const PICTURE_ICON = preload("res://scenes/pause/PictureIcon.tscn")
const QUIT_POPUP = preload("res://scenes/pause/quit_popup.tscn")
const SETTINGS = preload("res://scenes/settings/settings.tscn")

var is_picture_selected:bool = false :
	set(value):
		is_picture_selected = value
		$BlackFade.visible = is_picture_selected
		$BigPicture.visible = is_picture_selected

func populate_pictures()->void:
	if !is_node_ready(): await ready
	free_children(grid_container)
	var pic_ammount:int = GameManager.photos_taken.size()
	for i in range(16):
		var icon:PictureIcon = PICTURE_ICON.instantiate()
		if i < pic_ammount:
			#icon.mouse_entered.connect(_on_mouse_enter.bind(icon))
			#icon.mouse_exited.connect(_on_mouse_exit)
			#icon.focus_entered.connect(_on_mouse_enter.bind(icon))
			#icon.focus_exited.connect(_on_mouse_exit)
			icon.button_pressed.connect(_on_button_pressed)
			icon.picture = ImageTexture.create_from_image(GameManager.photos_taken[-(i+1)])
		else:
			icon.disabled = true
		grid_container.add_child(icon)

func free_children(node:Node)->void:
	if !node: return
	for child in node.get_children():
		if child.get_child_count() != 0:
			free_children(child)
		child.queue_free()


func _ready() -> void:
	grid_container.columns = grid_columns
	populate_pictures()

#func _on_mouse_enter(picture:PictureIcon) -> void:
	#current_hover = picture
#
#func _on_mouse_exit() -> void:
	#current_hover = null


func _input(event: InputEvent) -> void:
	if !is_picture_selected: return
	if event.is_pressed():
		big_picture.picture = null
		if animation_player.is_playing(): return
		animation_player.play_backwards("toggle_picture")
		await animation_player.animation_finished
		black_fade.hide()
		big_picture.hide()
		is_picture_selected = false


func _on_button_pressed(button:PictureIcon)->void:
	if is_picture_selected: return
	big_picture.picture = button.picture
	if animation_player.is_playing(): return
	black_fade.show()
	big_picture.show()
	animation_player.play("toggle_picture")
	await animation_player.animation_finished
	is_picture_selected = true


func _on_continue_pressed() -> void:
	##Basically it presses esc for you
	var input:InputEventAction = InputEventAction.new()
	input.action = "ctrl_menu"
	input.pressed = true
	Input.parse_input_event(input)



func _on_options_pressed() -> void:
	var instance = SETTINGS.instantiate()
	self.add_child(instance)
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	var popup:Popup = QUIT_POPUP.instantiate()
	get_tree().root.add_child(popup)

