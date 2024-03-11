extends Node


var player:Player
var camera:HeroCamera

const DIALOG:PackedScene = preload("res://scenes/dialog.tscn")
const PAUSE = preload("res://scenes/pause.tscn")

var dialog_scene:Dialog

var special_objects:Array[Variant]
var photos_taken:Array[Image] = [] :
	set(value):
		photos_taken = value
		while photos_taken.size() > 16:
			photos_taken.pop_at(0)

signal camera_state_change(is_on:bool)

var paused:bool = false :
	set(value):
		paused = value
		if !player :
			print("no player")
			return
		player.can_move = !paused
		player.can_look = !paused

var is_menu:bool = false

var p_screen_instance:CanvasLayer
var tree_paused:bool = false:
	set(value):
		tree_paused = value

func _ready()->void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var player_group:Array[Node] = get_tree().get_nodes_in_group("Player")
	if !player_group.is_empty():
		player = player_group[0]
	special_objects = get_tree().get_nodes_in_group("PartialVisibility")
	dialog_scene = DIALOG.instantiate()
	add_child(dialog_scene)
	dialog_scene.is_active = false


func pause()->void:
	paused = true

func unpause()->void:
	paused = false

func get_player()->Player:
	var player_group:Array[Node] = get_tree().get_nodes_in_group("Player")
	if !player_group.is_empty():
		return player_group[0]
	return null

func get_camera()->HeroCamera:
	if !player:
		print("no player")
		return null
	return player.camera_node

func dialog(text:Array[String])->void:
	dialog_scene.dialogue = text
	dialog_scene.start()
	await dialog_scene.finished
	unpause()
	dialog_scene.dialogue = []

func toggle_tree_paused() -> void:
	get_tree().paused = !get_tree().paused

func _unhandled_input(event: InputEvent) -> void:
	if is_menu: return
	if event.is_action_pressed("ctrl_menu"):
		toggle_tree_paused()
		get_viewport().set_input_as_handled()
		if get_tree().paused:
			p_screen_instance =  PAUSE.instantiate()
			get_tree().root.add_child(p_screen_instance)
		else:
			if is_instance_valid(p_screen_instance):
				p_screen_instance.queue_free()

