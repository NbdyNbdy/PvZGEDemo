extends RigidBody3D

func _ready():
	apply_central_impulse(Vector3(1,1,0))

func _on_timer_timeout():
	queue_free()
