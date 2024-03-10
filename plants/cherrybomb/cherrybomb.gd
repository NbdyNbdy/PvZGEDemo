extends Node3D

var damage = 1000

func _on_cherrybomb_area_entered(area):
	if area.has_method("takedamage"):
		area.takedamage(damage)
