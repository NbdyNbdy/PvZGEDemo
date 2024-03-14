extends Camera3D

var sun = 1000
var result
var wn = preload("res://plants/wallnut/wallnut.tscn")
var ps = preload("res://plants/peashooter/peashooter.tscn")
var sf = preload("res://plants/sunflower/sunflower.tscn")
var rp = preload("res://plants/repeater/repeater.tscn")
var pm = preload("res://plants/potatomine/potatomine.tscn")
var sp = preload("res://plants/snowpeashooter/snowpeashooter.tscn")
var c = preload("res://plants/chomper/chomper.tscn")
var cb = preload("res://plants/cherrybomb/cherrybomb.tscn")
var z1 = preload("res://zombies/zombie/zombie.tscn")
var fallingsun = preload("res://projectiles/fallingsun/fallingsun.tscn")

const raylength = 1000

@onready var zsp = [$"../zsp/Marker3D",$"../zsp/Marker3D2",$"../zsp/Marker3D3",$"../zsp/Marker3D4",$"../zsp/Marker3D5",$"../zsp/Marker3D6",$"../zsp/Marker3D7",$"../zsp/Marker3D8",$"../zsp/Marker3D9",$"../zsp/Marker3D10"]
@onready var ts = $"../Tileselect"

func _physics_process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	$"../Control/suntexture/sun".text = str(sun)
	var space_state = get_world_3d().direct_space_state
	var cam = $"."
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * raylength
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = false
	result = space_state.intersect_ray(query)
	if result:
		if Input.is_action_just_pressed("leftclick") and result.collider.is_in_group("normalsun"):
			sun += 25
			result.collider.queue_free()
		if result.collider.is_in_group("tile") or result.collider.is_in_group("selectable"):
			ts.show()
			ts.position = result.collider.global_transform.origin + Vector3(0, 0.1, 0)
		else:
			ts.hide()
	else:
		ts.hide()

#sees slots logic
func _on_psseed_button_up():
	if sun >= 100 and result and result.collider.is_in_group("tile"):
		sun -= 100
		var ps_a = ps.instantiate()
		result.collider.add_child(ps_a)
		$"../Control/psseed/AnimationPlayer".play("seed")

func _on_sfseed_button_up():
	if sun >= 50 and result and result.collider.is_in_group("tile"):
		sun -= 50
		var sf_a = sf.instantiate()
		result.collider.add_child(sf_a)
		$"../Control/sfseed/AnimationPlayer".play("seed")

func _on_rpseed_button_up():
	if sun >= 200 and result and result.collider.is_in_group("tile"):
		sun -= 200
		var rp_a = rp.instantiate()
		result.collider.add_child(rp_a)
		$"../Control/rpseed/AnimationPlayer".play("seed")

func _on_wnseed_button_up():
	if sun >= 50 and result and result.collider.is_in_group("tile"):
		sun -= 50
		var wn_a = wn.instantiate()
		result.collider.add_child(wn_a)
		$"../Control/wnseed/AnimationPlayer".play("seed")

func _on_pm_button_up():
	if sun >= 25 and result and result.collider.is_in_group("tile"):
		sun -= 25
		var pm_a = pm.instantiate()
		result.collider.add_child(pm_a)
		$"../Control/pm/AnimationPlayer".play("seed")

func _on_spseed_button_up():
	if sun >= 175 and result and result.collider.is_in_group("tile"):
		sun -= 175
		var sp_a = sp.instantiate()
		result.collider.add_child(sp_a)
		$"../Control/spseed/AnimationPlayer".play("seed")

func _on_cseed_button_up():
	if sun >= 150 and result and result.collider.is_in_group("tile"):
		sun -= 150
		var c_a = c.instantiate()
		result.collider.add_child(c_a)
		$"../Control/cseed/AnimationPlayer".play("seed")

func _on_cbseed_button_up():
	if sun >= 150 and result and result.collider.is_in_group("tile"):
		sun -= 150
		var cb_a = cb.instantiate()
		result.collider.add_child(cb_a)
		$"../Control/cbseed/AnimationPlayer".play("seed")

#others
func _on_shovel_button_down():
	print("shovelselected")

func _on_shovel_button_up():
	if result:
		if result.collider.is_in_group("selectable"):
			result.collider.queue_free()

func _on_zsp_timeout():
	var randomIndex = randi() % zsp.size()
	var spawnPosition = zsp[randomIndex].global_transform.origin
	var z1a = z1.instantiate()
	z1a.position = spawnPosition
	get_tree().get_root().add_child(z1a)
	randomize_timer()

func randomize_timer():
	var randomInterval = randi_range(1.0, 35.0)
	$"../zsp/zsp".wait_time = randomInterval

func _on_sspt_timeout():
	var fallingsuna = fallingsun.instantiate()
	fallingsuna.global_transform.origin = $"../ssp/ssp".global_transform.origin
	get_tree().get_root().add_child(fallingsuna)

func _on_gameover_area_entered(area):
	if area.is_in_group("zombie"):
		get_tree().quit()
		print("Game Over, Game over screen not yet added")
