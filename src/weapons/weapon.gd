extends Node2D

signal emit_bullet(projectile)
signal emit_laser(projectile)

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1
export(PackedScene) var PROJECTILE
export(PackedScene) var LASER


var aim_point = Vector2.ZERO setget ,get_aim_point

var locked := false setget set_locked
var parent : Node
var queue_shot := false

var cooldown_mod := 1.0
var damage_mod := 1


var flags := {
	'empower': false,
	'melee': true,
	'bullet': false,
	'laser': false,
}

onready var bulletS := $Bullet
onready var meleeS := $Melee
onready var laserS := $Laser


func set_locked(_locked):
	if not _locked and queue_shot:
		fire()
	locked = _locked

func _ready():
	$Cooldown.wait_time = COOLDOWN * cooldown_mod
	update()

func change_weapon(weapon: String):
	if weapon == 'melee':
		flags.melee = true
		flags.bullet = false
		flags.laser = false
	elif weapon == 'bullet':
		flags.bullet = true
		flags.melee = false
		flags.laser = false
	elif weapon == 'laser':
		flags.melee = false
		flags.bullet = false
		flags.laser = true

	if $Cooldown.is_stopped():
		update()

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
	if flags.melee:
		damage_mod = 5
		cooldown_mod = 5
		melee_attack()
	elif flags.bullet:
		damage_mod = 1
		cooldown_mod = 1
		emit_bullet()
	elif flags.laser:
		damage_mod = 1
		cooldown_mod = 5
		laser_attack()
	else:
		print('Either melee or bullet must be active.')
	if flags.empower:
		damage_mod *= 2
		cooldown_mod *= 2

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
	meleeS.frame = 0
	meleeS.play()
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


#func laser_attack():
#	$Laser.attacking = true
#	$Laser/Body.show()
#	for hurtbox in $Laser/LaserHitBox.get_overlapping_areas():
#		hurtbox.take_damage(DAMAGE * damage_mod)
#		print(hurtbox)
#		$Laser/Particles2D.global_position = hurtbox.global_position
#		$Laser/Particles2D.restart()
#	yield(get_tree().create_timer(0.3), "timeout")
#	$Laser.attacking = false
#	$Laser/Body.hide()

func update():
	if $Cooldown.is_stopped():
		if flags.melee:
			bulletS.hide()
			meleeS.show()
			laserS.hide()
		elif flags.bullet:
			bulletS.show()
			meleeS.hide()
			laserS.hide()
		elif flags.laser:
#			laserS.show()
			bulletS.hide()
			meleeS.hide()
			
