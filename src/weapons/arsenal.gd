extends Node2D

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1

var parent: Node setget set_parent

var active_weapon_node: Node
var active_weapon: int setget set_weapon

onready var weapons = $Weapons

func _ready():
	for weapon in weapons.get_children():
		weapon.hide()
	self.active_weapon = 0

func trigger():
	active_weapon_node.trigger()

func release():
	active_weapon_node.release()

func change_weapon(name: String):
	var f = weapons.get_node(name)
	if active_weapon_node == f:
		return

	if active_weapon_node:
		active_weapon_node.hide()

	active_weapon_node = f
	active_weapon_node.show()

func scroll_weapon(by: int):
	self.active_weapon = (self.active_weapon + by) % weapons.get_child_count()

func next_weapon():
	scroll_weapon(+1)

func prev_weapon():
	scroll_weapon(-1)

func set_parent(val):
	parent = val
	for weapon in $Weapons.get_children():
		weapon.parent = val

func set_weapon(val: int):
	if val < 0 or val >= weapons.get_child_count():
		print("tried a invalid weapons' index", val)
		return
	active_weapon = val

	var new_weapon = weapons.get_children()[val]
	if active_weapon_node == new_weapon:
		return

	if active_weapon_node != null:
		active_weapon_node.hide()

	active_weapon_node = new_weapon
	active_weapon_node.show()
