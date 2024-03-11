class_name PlayerPreferences
extends Resource

@export_group("Sensitivities")
@export var mouse_sensitivity:float = 1
@export var mouse_invert_x:bool = false
@export var mouse_invert_y:bool = true
@export var joy_invert_x:bool = false
@export var joy_invert_y:bool = false
@export var joy_sensitivity:float = 1
@export_group("Gameplay Settings")
@export var fov:float = 75
@export var save_picture:bool = true
@export_global_dir var save_location:String = "user://"
@export_group("Window Settings")
@export var window_mode:String
@export var window_size:Vector2i
@export var custom_window_sizes:Array[Vector2i]
@export var v_sync:bool = true
@export_group("Sound Settings")
@export var master_volume:float = 100
@export var music_volume:float = 100
@export var sfx_volume:float = 100
@export var voice_volume:float = 100

