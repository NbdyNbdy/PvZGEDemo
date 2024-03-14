extends StaticBody3D

var health = 100
var can_eat = true
var damage = 1000
var collider

func takedamage(damage):
	health -= damage
	if health <= 0:
		queue_free()

func swallow():
	$AnimationPlayer.play("swallow")

func idle():
	can_eat = true
	$AnimationPlayer.play("idle")

func eat():
	if collider and collider.has_method("takedamage"):
		collider.takedamage(damage)

func _on_cooldown_timeout():
	swallow()

func _physics_process(delta):
	collider = $RayCast3D.get_collider()
	if can_eat and collider and collider.is_in_group("zombie"):
		$cooldown.start()
		can_eat = false
		$AnimationPlayer.play("eat")
		$AnimationPlayer.queue("chew")

