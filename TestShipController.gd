extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(float) var DEADZONE = 0.1
var zoom_level = 1.0
var is_controlling_camera = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func control_ship (move_vector, look_vector, dt):
	$Ship/Ship.move(move_vector, dt)
	if look_vector.length() > 0.3:
		$Ship/Ship.look(Vector2(-look_vector.y, look_vector.x), dt)
		
func control_camera (move_vector, look_vector, dt):
	var scale_factor = exp(look_vector.x * 1.0 * dt)
	get_viewport().canvas_transform = get_viewport().canvas_transform \
		.translated(
			Vector2(-move_vector.x, move_vector.y) * dt * 1000.0
			#get_viewport().size * (1.0 - scale_factor)
		) \
		.scaled(Vector2(scale_factor, scale_factor))

func _process (dt):
	var move_vector = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_0),
		-Input.get_joy_axis(0, JOY_AXIS_1))
	if move_vector.length() <= DEADZONE:
		move_vector = Vector2(0, 0)
		
	var look_vector = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_2),
		Input.get_joy_axis(0, JOY_AXIS_3))
		
	if look_vector.length() <= DEADZONE:
		look_vector = Vector2(0, 0)
		
	if Input.is_action_just_pressed("ui_accept"):
		is_controlling_camera = not is_controlling_camera
	
	if is_controlling_camera:
		control_camera(move_vector, look_vector, dt)
	else:
		control_ship(move_vector, look_vector, dt)
