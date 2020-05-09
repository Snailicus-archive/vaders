extends Area2D

signal shot

export(float) var cooldown = 0.5
export(PackedScene) var projectile

var cooldown_mod := 1.0

var melee_damage := 1

onready var queue_shot := false

var parent

# flags
var empower := false
var melee_on := false


func _ready():
	$Cooldown.wait_time = cooldown * cooldown_mod

func trigger():
	if $Cooldown.is_stopped():
		fire()
	queue_shot = true

func release():
	queue_shot = false

func fire():
	if melee_on:
		cooldown_mod *= 1
		melee_attack()
	else:
		shoot_projectile()
		
	$Cooldown.wait_time = cooldown * cooldown_mod
	$Cooldown.start()
		
func shoot_projectile():
	var parent_velocity = parent.velocity if parent else Vector2.ZERO
	emit_signal("shot", projectile, $Muzzle.global_position, 
		global_rotation, parent_velocity)
	
func _on_Cooldown_timeout():
	if queue_shot:
		fire()

# 
func melee_attack():
	for body in self.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(melee_damage)
	
	
