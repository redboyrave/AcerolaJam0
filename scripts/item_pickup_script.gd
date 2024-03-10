@tool
extends Node3D



@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var spot_light: SpotLight3D = $SpotLight
@export var item:String
@export var mesh:Mesh:
	set(value):
		mesh = value
		if !(mesh_instance and mesh != null): return
		var aabb:AABB = mesh_instance.get_aabb()
		mesh_instance.mesh = mesh
		collision_shape.shape.size = aabb.size
		collision_shape.position = aabb.get_center()
		mesh_instance.position = Vector3.ZERO
		spot_light.position = aabb.get_center() + (Vector3.UP*.25*spot_light.scale)
		var angle:float = asin(spot_light.spot_range/aabb.get_longest_axis_size())*2
		spot_light.spot_angle = rad_to_deg(angle)

@export var material:Material:
	set(value):
		material = value
		if !mesh_instance: return
		mesh_instance.material_override = material

func _ready()->void:
	mesh = mesh

func interact(origin:Node3D) -> void:
	print(item)
	if !origin is Player: return
	var player:Player = origin as Player
	player.inventory.append(item)
	queue_free()
