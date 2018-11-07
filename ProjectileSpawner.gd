extends Node2D

export(PackedScene) var projectile;
export(float) var fire_rate = 100# setget setFireRate, getFireRate
export(float) var projectile_speed = 500.0

func setFireRate (rate):
	fire_rate = rate
	$Timer.wait_time = 1.0 / fire_rate
	#print("Set wait time: %s"%$Timer.wait_time)
	
func _ready ():
	$Timer.wait_time = 1.0 / fire_rate
	
func getFireRate ():
	return fire_rate

func set_firing (firing):
	if firing and $Timer.is_stopped():
		#_fire()
		$Timer.start()
	elif not firing:
		$Timer.stop()

func _fire ():
	#print("FIRE!")
	var p = projectile.instance()
	var node = self
	while node.get_parent():
		node = node.get_parent()
	node.add_child(p)
	p.init(
		get_global_transform().xform(Vector2(0, 0)),
		get_global_transform().get_rotation(),
		projectile_speed
	)	
	if $Timer.is_stopped():
		$Timer.start()

func _on_Timer_timeout():
	_fire()
	
func _process (dt):
	set_firing(Input.get_joy_axis(0, JOY_AXIS_7) > 0.5)
