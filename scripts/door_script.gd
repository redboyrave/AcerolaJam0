@tool
class_name Door
extends AnimatableBody3D

@export var is_locked:bool = false :
	set(value):
		print("notify list change")
		is_locked = value
		notify_property_list_changed()
var is_open:bool = false
var key_to_open:String = ""

@onready var initial_rotation:float = rotation.y;



func _get_property_list() -> Array[Dictionary]:
	var property:Array[Dictionary] = []

	var prop_usage:int = PROPERTY_USAGE_DEFAULT
	if !is_locked:
		prop_usage = PROPERTY_USAGE_NO_EDITOR
	property.append(
		{
			"name" = "key_to_open",
			"type" = TYPE_STRING,
			"usage" = prop_usage,
			"hint" = PROPERTY_HINT_PLACEHOLDER_TEXT,
			"hint_string" = "Key name"
		}
	)

	return property

func interact(_origin:Node3D)->void:
	if is_locked: print(key_to_open)
	if is_locked:
		if !_origin is Player:
			return
		var p:Player = _origin as Player
		if !p.inventory.has(key_to_open):
			return
	var tween:Tween = get_tree().create_tween()
	var desired_rotation:float = initial_rotation if is_open else initial_rotation - deg_to_rad(100)
	is_open = !is_open
	tween.tween_property(self,"rotation:y", desired_rotation,.5)
	tween.set_ease(Tween.EASE_IN)
	tween.play()
