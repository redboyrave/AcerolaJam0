extends Node3D

@export_category("Camera FOV")
@export var camera_fov:float = 50;
@export_category("Node Paths")
@export_node_path("Marker3D") var camera_location_path:NodePath
@export_node_path("SubViewport") var subviewport_path:NodePath
@export_node_path("MeshInstance3D") var viewfinder_path:NodePath

@onready var camera_location:Marker3D = get_node(camera_location_path) if camera_location_path else null
@onready var subviewport:SubViewport = get_node(subviewport_path) if subviewport_path else null
@onready var viewfinder:MeshInstance3D = get_node(viewfinder_path) if viewfinder_path else null
@onready var camera:Camera3D = $SubViewport/Camera3D

var is_camera_on:bool = false;

var camera_texture:Texture
var off_texture:Texture


func toggle_camera()->void:
	is_camera_on = !is_camera_on;
	#change_viewport(camera_texture if is_camera_on else off_texture)

func _ready()->void:
	camera_texture = subviewport.get_texture()
	off_texture = ImageTexture.create_from_image(Image.create(1,1,false,Image.FORMAT_L8))
	change_viewport()

func _process(_delta:float)->void:
	camera.global_transform = camera_location.global_transform

func change_viewport()->void:
	## CALLED BY THE ANIMATION PLAYER
	var new_texture:Texture = camera_texture if is_camera_on else off_texture
	viewfinder.get_surface_override_material(1).set_shader_parameter("texture_albedo",new_texture)

func on_fov_set(value:float) -> void:
	camera_fov = value
	$SubViewport/Camera3D.fov = camera_fov
