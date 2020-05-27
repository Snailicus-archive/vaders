extends Node2D

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1

var parent: Node
var aim_point = Vector2.ZERO setget ,get_aim_point
var active_weapon: Node
var cooldown_mod := 1.0
var damage_mod := 1
var sigils: Array #for ease of use and testing. will be deleted later.

onready var cooldown = $Cooldown
onready var weapons = $Weapons

func _ready():
	for weapon in weapons.get_children():
		weapon.hide()
	cooldown.wait_time = COOLDOWN * cooldown_mod
	change_form('Laser')

	DebugInfo.add_stat("Weapon triggering", self, "_weapon_triggered", true)

	for sigil in $Sigils.get_children():
		sigils.append(sigil)

func trigger():
	if cooldown.is_stopped():
		action(get_params())
		cooldown.start()
	cooldown.one_shot = false

func release():
	cooldown.one_shot = true

func change_form(name: String):
	var f = weapons.get_node(name)
	if active_weapon == f:
		return

	if active_weapon:
		active_weapon.hide()

	active_weapon = f
	active_weapon.show()

func _on_Cooldown_timeout():
	if not cooldown.one_shot:
		action(get_params())

func action(params):
	active_weapon.action(get_params())
	
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

func get_params():
	return {
		"from": self.global_position,
		"direction": self.global_rotation,
		"to": self.aim_point,
		"parent_velocity": (parent.velocity if parent else Vector2.ZERO),
		"sigils": self.sigils # sigils here or standalone? eh
	}

func _weapon_triggered() -> bool:
	return not cooldown.one_shot
