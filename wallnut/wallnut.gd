extends StaticBody3D

var health = 1000
var wn1candetach = true
var wn2candetach = true
var wn1 = preload("res://plants/wallnut/wallnut1.tscn")
var wn2 = preload("res://plants/wallnut/wallnut2.tscn")

func takedamage(damage):
	health -= damage
	if health <= 750:
		wn1detach()
		$wallnut/mouth/AnimationPlayer.play("1")
	if health <= 250:
		wn2detach()
		$wallnut/mouth/AnimationPlayer.play("2")
	if health <= 0:
		queue_free()

func wn1detach():
	if wn1candetach:
		$wallnut/wallnut1.hide()
		var wn1a = wn1.instantiate()
		wn1a.global_transform.origin = $Marker3D.global_transform.origin
		get_tree().get_root().add_child(wn1a)
		wn1candetach = false

func wn2detach():
	if wn2candetach:
		$wallnut/wallnut2.hide()
		var wn2a = wn2.instantiate()
		wn2a.global_transform.origin = $Marker3D2.global_transform.origin
		get_tree().get_root().add_child(wn2a)
		wn2candetach = false
