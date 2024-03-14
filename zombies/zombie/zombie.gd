extends StaticBody3D

var health = 100
var damage = 5
var translation = Vector3(-0.005,0,0)
var gbody
var arm_can_detach = true
var head_can_detach = true
var arm = preload("res://zombies/zombiearm.tscn")
var head = preload("res://zombies/zombie/zombiehead.tscn")
var chilled = false

@onready var ap = $AnimationPlayer

func _physics_process(delta):
	if health <= 50:
		armdetach()
	if health <= 0:
		ap.play("die")
	translate(translation)

func walk():
	ap.play("walk")
	if chilled:
		ap.speed_scale = 0.25
	else:
		ap.speed_scale = 1.0

func walkforward():
	translation = Vector3(-0.01, 0, 0)

func stopwalk():
	translation = Vector3(0, 0, 0)

func _on_hitbox_body_entered(body):
	if body.is_in_group("plant"):
		gbody = body
		if gbody:
			ap.play("eat")
	else:
		walk()
		gbody = null

func _on_hitbox_body_exited(body):
	ap.play("walk")
	if chilled:
		ap.speed_scale = 0.5
	else:
		ap.speed_scale = 1.0
	gbody = null

func eat():
	if gbody != null:
		gbody.takedamage(damage)
	else:
		walk()

func armdetach():
	if arm_can_detach:
		$zombie/body/arma/armb.hide()
		var arm2 = arm.instantiate()
		arm2.global_transform.origin = $Marker3D.global_transform.origin
		get_tree().get_root().add_child(arm2)
		arm_can_detach = false

func headdeteach():
	if head_can_detach:
		$zombie/body/head.hide()
		var head2 = head.instantiate()
		head2.global_transform.origin = $Marker3D2.global_transform.origin
		get_tree().get_root().add_child(head2)
		head_can_detach = false
