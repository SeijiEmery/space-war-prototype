extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(int) var SHIP_SPEED = 200;
export(float) var ship_thrust = 100.0;
export(float) var ship_steering_torque = 100.0;
export(float) var damping = 0.1;

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func move (dir):
	print(dir * ship_thrust)
	$RigidBody2D.add_force(Vector2(0, 0), Vector2(0, dir.y * ship_thrust))
	#$RigidBody2D.add_torque(dir.x * ship_steering_torque)
	
func look (dir):
	var i = $RigidBody2D/Turrets.get_child_count()
	while i > 0:
		i -= 1
		$RigidBody2D/Turrets.get_child(i).look(dir)
	
	
	
#func _integrate_forces(state):
#	state.add_force(Vector2(0, 0), Vector2(ship_thrust, ship_thrust))
	
func _process(dt):
	var v = $RigidBody2D.linear_velocity.length()
	$RigidBody2D.add_force(
		Vector2(0, 0),
		$RigidBody2D.linear_velocity * (damping - 1) * dt)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
