extends Node2D

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1

var parent: Node setget set_parent

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

func trigger():
	active_weapon.trigger()

func release():
	active_weapon.release()

func change_weapon(name: String):
	var f = weapons.get_node(name)
	if active_weapon == f:
		return

	if active_weapon:
		active_weapon.hide()

	active_weapon = f
	active_weapon.show()


func set_parent(val):
	parent = val
	for weapon in $Weapons.get_children():
		weapon.parent = val

