extends Node2D

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1

var parent: Node setget set_parent
var aim_point = Vector2.ZERO setget ,get_aim_point
var active_weapon: Node
var cooldown_mod := 1.0
var damage_mod := 1

onready var cooldown = $Cooldown
onready var weapons = $Weapons

func _ready():
	for weapon in weapons.get_children():
		weapon.hide()
	cooldown.wait_time = COOLDOWN * cooldown_mod
	change_weapon('Laser')

	DebugInfo.add_stat("Weapon triggering", self, "_weapon_triggered", true)


func trigger():
	if cooldown.is_stopped():
		action()
		cooldown.start()
	cooldown.one_shot = false

func release():
	cooldown.one_shot = true

func change_weapon(name: String):
	var f = weapons.get_node(name)
	if active_weapon == f:
		return

	if active_weapon:
		active_weapon.hide()

	active_weapon = f
	active_weapon.show()

func _on_Cooldown_timeout():
	if not cooldown.one_shot:
		action()

func action():
	active_weapon.action()
	
func attack():
	pass

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position,
		(global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist

func set_parent(val):
	parent = val
	for weapon in $Weapons.get_children():
		weapon.parent = val

func _weapon_triggered() -> bool:
	return not cooldown.one_shot
