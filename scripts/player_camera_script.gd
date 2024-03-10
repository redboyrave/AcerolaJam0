extends Camera3D

var input_rotation:Vector2

func _process(_delta:float) -> void:
	input_rotation = get_joy_look()

func _unhandled_input(event:InputEvent) -> void:
	#camera rotation from mouse
	if event is InputEventMouseMotion:
		camera_look(get_mouse_look(event as InputEventMouseMotion))
		get_viewport().set_input_as_handled()
	if event is InputEventJoypadMotion:
		camera_look(input_rotation)
		get_viewport().set_input_as_handled()

func camera_look(direction:Vector2)->void:
	if get_parent().can_look:
		rotate_body(direction.x)
		rotate_view(direction.y)

func get_mouse_look(mouse:InputEventMouseMotion)->Vector2: #returns the scaled output of the mouse input
	var rightleft:float = mouse.relative.x * (-1 if SaveManager.preferences.mouse_invert_x else 1)
	var updown:float = mouse.relative.y * (-1 if SaveManager.preferences.mouse_invert_y else 1)

	return Vector2(rightleft,updown) * SaveManager.preferences.mouse_sensitivity

func get_joy_look()->Vector2:
	var vector:Vector2 = circularize_vector(Input.get_vector("ctrl_look_right","ctrl_look_left","ctrl_look_down","ctrl_look_up"))
	vector *= Vector2(
		-1 if SaveManager.preferences.joy_invert_x else 1,
		-1 if SaveManager.preferences.joy_invert_y else 1
	)
	return vector * SaveManager.preferences.joy_sensitivity * 5
func circularize_vector(input_vector:Vector2) -> Vector2:
	return Vector2(
		input_vector.x * sqrt(1 - (input_vector.y * input_vector.y)/2),
		input_vector.y * sqrt(1 - (input_vector.x * input_vector.x)/2))

func rotate_body(ammount:float)->void:
	get_parent().rotate_y(deg_to_rad(ammount))

func rotate_view(ammount:float)->void:
	var rot:Vector3 = self.get_rotation()
	rot.x += deg_to_rad(ammount)
	rot.x = clamp(rot.x,-PI/2,PI/2)
	self.set_rotation(rot)
