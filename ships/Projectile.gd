extends RigidBody2D

var velocity = Vector2(0, 0)

func init (pos, rot, speed):
	#var dir = Vector2(cos(rot), sin(rot))
	position = get_global_transform().xform_inv(pos)
	velocity = Vector2(sin(rot), -cos(rot)) * speed
	rotation = rot
	#print("init projectile: %s, %s"%[position, velocity])

func _integrate_forces (state):
	state.linear_velocity = velocity

func _on_Timer_timeout():
	#print("Killing projectile")
	get_parent().remove_child(self)
