extends StaticBody3D

var health = 100

@onready var ap = $AnimationPlayer
@onready var sun = preload("res://projectiles/sun/sun.tscn")

func producesun():
	var sun2 = sun.instantiate()
	sun2.position = $sunflower/head.global_transform.origin + Vector3(0,2,0)
	get_tree().get_root().add_child(sun2)

func takedamage(damage):
	health -= damage
	if health <= 0:
		queue_free()

func _on_timer_timeout():
	ap.play("producesun")
	ap.queue("idle")
