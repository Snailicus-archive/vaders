extends Node2D


signal emit_bullet(projectile)
signal emit_laser(projectile)

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

func _ready():
	for weapon in $Models.get_children():
		weapon.hide()
	$Cooldown.wait_time = COOLDOWN * cooldown_mod
	change_weapon('Laser')

func change_weapon(name: String):
	var w = $Models.get_node(name)
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
		'Melee':
			damage_mod = 5
			cooldown_mod = 5
			melee_attack()
		'Bullet':
			damage_mod = 1
			cooldown_mod = 1
			emit_bullet()
		'Laser':
			damage_mod = 1
			cooldown_mod = 5
			laser_attack()
		_:
			print('Either melee or bullet must be active.')

	$Cooldown.wait_time = COOLDOWN * cooldown_mod
	$Cooldown.start()

func emit_bullet():
	var parent_velocity = parent.velocity if parent else Vector2.ZERO
	var p = PROJECTILE.instance()
	p.global_rotation = global_rotation
	p.global_position = $Muzzle.global_position
	p.shoot(parent_velocity)
	emit_signal("emit_bullet", p)

func emit_laser():
	var p = LASER.instance()
	p.global_position = global_position
	p.global_rotation = global_rotation
	print((global_position - self.aim_point).length())
	p.shoot((global_position - self.aim_point).length())
	emit_signal("emit_laser", p)

func melee_attack():
	$Models/Melee.frame = 0
	$Models/Melee.play()
	for hurtbox in $Hitbox.get_overlapping_areas():
		hurtbox.take_damage(DAMAGE * damage_mod)

func laser_attack():
	emit_laser()

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position,
		(global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist
