@tool
class_name SpecialObject
extends Node

@export var show_for_camera:bool : set = set_camera_visible
@export var show_for_player:bool : set = set_player_visible
@export var show_for_photo:bool  : set = set_photo_visible

var meshes:Array = get_children_of_type(self,MeshInstance3D)
var multimeshes:Array = get_children_of_type(self,MultiMeshInstance3D)
var physics_body:Array = get_children_of_type(self,PhysicsBody3D)

func _ready() -> void:
	add_to_group("PartialVisibility")
	meshes = get_children_of_type(self,MeshInstance3D)
	multimeshes = get_children_of_type(self,MultiMeshInstance3D)
	physics_body = get_children_of_type(self,PhysicsBody3D)
	for mesh:MeshInstance3D in meshes:
		mesh.set_layer_mask_value(1,false)
	for mesh:MultiMeshInstance3D in multimeshes:
		mesh.set_layer_mask_value(1,false)
	set_camera_visible(show_for_camera)
	set_player_visible(show_for_player)
	on_visibility_change(false)
	if Engine.is_editor_hint(): return
	GameManager.camera_state_change.connect(on_visibility_change)

func set_camera_visible(value:bool)->void:
	show_for_camera = value
	for mesh:MeshInstance3D in meshes:
		mesh.set_layer_mask_value(6,show_for_camera)
	for mesh:MultiMeshInstance3D in multimeshes:
		mesh.set_layer_mask_value(6,show_for_camera)

func set_player_visible(value:bool)->void:
	show_for_player = value
	for mesh:MeshInstance3D in meshes:
		mesh.set_layer_mask_value(7,show_for_player)
	for mesh:MultiMeshInstance3D in multimeshes:
		mesh.set_layer_mask_value(7,show_for_player)

func set_photo_visible(value:bool)->void:
	show_for_photo = value
	for mesh:MeshInstance3D in meshes:
		mesh.set_layer_mask_value(10,show_for_photo)
	for mesh:MultiMeshInstance3D in multimeshes:
		mesh.set_layer_mask_value(10,show_for_photo)

func get_children_of_type(node:Variant,type:Variant)->Array[Variant]:
	var array:Array[Variant] = []
	if is_instance_of(node,type):
		array.append(node)
	for child:Variant in node.get_children():
		array.append_array(get_children_of_type(child,type))
	return array


##if the camera is on and can see, it's collision should be on
##if the camera is off and can't see, collision should be off
func on_visibility_change(is_on:bool)->void:
	for body:PhysicsBody3D in physics_body:
		for child:Variant in body.get_children():
			if !child is CollisionShape3D: continue
			if show_for_camera:
				child.disabled = !is_on
			if show_for_player:
				child.disabled = is_on


