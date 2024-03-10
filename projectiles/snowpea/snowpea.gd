extends Area3D

var damage = 10
var translation = Vector3(0.15,0,0)

func _physics_process(delta):
	translate(translation)

func _on_body_entered(body):
	if body.has_method("takedamage"):
		body.takedamage(damage)
		body.chilled = true
	queue_free()


func _on_area_entered(area):
	if area.has_method("takechilldamage"):
		area.takechilldamage(damage)
	queue_free()
