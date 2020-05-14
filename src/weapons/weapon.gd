extends Node2D

signal shot

export(float) var cooldown := 0.5
export(int) var damage := 1
export(PackedScene) var projectile

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
	$Cooldown.wait_time = cooldown * cooldown_mod
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
		shoot_projectile()
	elif flags.laser:
		damage_mod = 1
		cooldown_mod = 5
		laser_attack()
	else:
		print('Either melee or bullet must be active.')
	if flags.empower:
		damage_mod *= 2
		cooldown_mod *= 2

	$Cooldown.wait_time = cooldown * cooldown_mod
	$Cooldown.start()
		
func shoot_projectile():
	var parent_velocity = parent.velocity if parent else Vector2.ZERO
	emit_signal("shot", projectile, $Muzzle.global_position,
		global_rotation, parent_velocity)

func melee_attack():
	meleeS.frame = 0
	meleeS.play()
	for hurtbox in $Hitbox.get_overlapping_areas():
		hurtbox.take_damage(damage * damage_mod)

func laser_attack():
	$Laser.attacking = true
	for hurtbox in $Laser/LaserHitBox.get_overlapping_areas():
		hurtbox.take_damage(damage * damage_mod)
		$Laser/Particles2D.global_position = hurtbox.global_position
		$Laser/Particles2D.restart()
	yield(get_tree().create_timer(0.3), "timeout")	
	$Laser.attacking = false

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
			laserS.show()
			bulletS.hide()
			meleeS.hide()
			
