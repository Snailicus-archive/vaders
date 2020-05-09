extends Node2D

signal shot

export(float) var cooldown := 0.5
export(int) var damage := 1
export(PackedScene) var projectile

var parent : Node
var queue_shot := false
var enemies_in_range := []

var cooldown_mod := 1.0
var damage_mod := 1


var flags := {
	'empower': false,
	'melee': true,
	'bullet': false,
}

func _ready():
	$Cooldown.wait_time = cooldown * cooldown_mod

func trigger():
	if $Cooldown.is_stopped():
		fire()
	queue_shot = true

func release():
	queue_shot = false

func _on_Cooldown_timeout():
	if queue_shot:
		fire()

func fire():
	if flags.melee:
		damage_mod = 1
		melee_attack()
	elif flags.bullet:
		damage_mod = 1
		shoot_projectile()
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
	for hurtbox in $Hitbox.get_overlapping_areas():
		if hurtbox.has_method("take_damage"):
			hurtbox.take_damage(damage)
