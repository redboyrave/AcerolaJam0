extends Node3D

@export var image:Texture :set = set_image
@export var clip_threshold:float = .5 : set = set_clip
@export var billboard:bool : set= set_billboard
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D



func _ready() -> void:
	create_material()

func set_image(value:Texture) -> void:
	image=value
	await is_ready(self)
	mesh_instance.material_override = create_material()

func set_clip(value:float) -> void:
	clip_threshold = value
	await is_ready(self)
	mesh_instance.material_override = create_material()

func set_billboard(value:bool) -> void:
	billboard = value
	await is_ready(self)
	mesh_instance.material_override = create_material()


func is_ready(node:Node3D)->void:
	if !node.is_node_ready(): await node.ready
	return

func create_material() -> StandardMaterial3D:
	var mat:StandardMaterial3D = StandardMaterial3D.new()
	mat.albedo_texture = image
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_HASH

	mat.alpha_scissor_threshold = clip_threshold
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	var billboard_flag:BaseMaterial3D.BillboardMode
	if billboard:
		billboard_flag = BaseMaterial3D.BILLBOARD_ENABLED
		mat.billboard_keep_scale = true
	else:
		billboard_flag = BaseMaterial3D.BILLBOARD_DISABLED
	mat.billboard_mode =  billboard_flag

	return mat
