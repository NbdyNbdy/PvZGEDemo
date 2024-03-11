extends StaticBody3D

var health = 100
var can_explode = false
var damage = 1000

func _physics_process(delta):
	var collider = $RayCast3D.get_collider()
	if collider and collider.is_in_group("zombie"):
		$AnimationPlayer.play("explode")

func armed():
	can_explode = true
	$AnimationPlayer.play("idle")

func _on_area_3d_area_entered(area):
	if area and can_explode and area.has_method("takedamage"):
		area.takedamage(damage)
