extends RigidBody2D

var velocity = Vector2(0, 0)

func init (pos, vel):
	position = get_global_transform().xform_inv(pos)
	print("init projectile: %s, %s"%[position, vel])

func _integrate_forces (state):
	state.linear_velocity = velocity

func _on_Timer_timeout():
	print("Killing projectile")
	get_parent().remove_child(self)
