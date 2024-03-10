extends Area3D

func takedamage(damage):
	$"..".health -= damage

func takechilldamage(damage):
	$"..".health -= damage
	$"..".chilled = true
