extends Node2D

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1
export(PackedScene) var PROJECTILE
export(PackedScene) var LASER

var aim_point = Vector2.ZERO setget ,get_aim_point
var active_weapon: Node
var locked := false setget set_locked
var parent: Node
var queue_shot := false
var cooldown_mod := 1.0
var damage_mod := 1

onready var weapons = $Weapons

func _ready():
	for weapon in weapons.get_children():
		weapon.hide()
	$Cooldown.wait_time = COOLDOWN * cooldown_mod
	change_weapon('Laser')

func change_weapon(name: String):
	var w = weapons.get_node(name)
	if active_weapon == w:
		return

	if active_weapon:
		active_weapon.hide()

	active_weapon = w
	active_weapon.show()

func set_locked(_locked):
	if not _locked and queue_shot:
		fire()
	locked = _locked

func trigger():
	if $Cooldown.is_stopped() and not locked:
		fire()
	queue_shot = true

func release():
	queue_shot = false

func _on_Cooldown_timeout():
	update()
	if queue_shot and not locked:
		fire()

func fire():
	match active_weapon.name:
		'Cone':
			cone_attack()
		'Bullet':
			bullet_attack()
		'Laser':
			laser_attack()
		_:
			print('Either melee or bullet must be active.')

	$Cooldown.wait_time = COOLDOWN * cooldown_mod
	$Cooldown.start()

func cone_attack():
	active_weapon.action(self.global_position, self.global_rotation)

func bullet_attack():
	var parent_velocity = parent.velocity if parent else Vector2.ZERO
	active_weapon.action(self.global_position, self.global_rotation, parent_velocity)

func laser_attack():
	active_weapon.action(self.global_position, self.aim_point)

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position,
		(global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist
