extends RigidBody3D

func _ready():
	apply_central_impulse(Vector3(2,2,0))


func _on_timer_timeout():
	queue_free()
