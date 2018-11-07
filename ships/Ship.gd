extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(float) var ship_speed = 100.0;
export(float) var ship_turn_speed = deg2rad(60.0);
export(float) var damping = 0.99;
#var linear_velocity = Vector2(0, 0)
#var angular_velocity = 0.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func move (dir, dt):
	var r = get_global_transform().get_rotation()
	linear_velocity = \
		linear_velocity * (1.0 - damping * dt) + \
		Vector2(-sin(r), cos(r)) * dir.y * ship_speed * (damping * dt)
	angular_velocity = angular_velocity * (1.0 - damping * dt) - \
		dir.x * ship_turn_speed * (damping * dt)
	print("%s, %s"%[ linear_velocity, angular_velocity ])
	
func look (dir, dt):
	var i = $Turrets.get_child_count()
	while i > 0:
		i -= 1
		$Turrets.get_child(i).look(dir)

#func _fixed_process(dt):
#	$RigidBody2D.linear_velocity = linear_velocity
#	$RigidBody2D.angular_velocity = angular_velocity
#	print("%s, %s"%[ $RigidBody2D.linear_velocity, $RigidBody2D.angular_velocity ])
	
#func _process(dt):
#	var v = $RigidBody2D.linear_velocity.length()
#	$RigidBody2D.add_force(
#		Vector2(0, 0),
#		$RigidBody2D.linear_velocity * (damping - 1) * dt)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
