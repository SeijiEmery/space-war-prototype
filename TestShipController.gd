extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(float) var DEADZONE = 0.1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process (delta):
	var move_vector = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_0),
		-Input.get_joy_axis(0, JOY_AXIS_1))
	if move_vector.length() <= DEADZONE:
		move_vector = Vector2(0, 0)
		
	var look_vector = Vector2(
		-Input.get_joy_axis(0, JOY_AXIS_3),
		Input.get_joy_axis(0, JOY_AXIS_2))
		
	if look_vector.length() <= DEADZONE:
		look_vector = Vector2(0, 0)
		
	$Ship.move(move_vector * delta)
	if look_vector.length() > 0.3:
		$Ship.look(look_vector * delta)
