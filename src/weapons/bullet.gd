extends KinematicBody2D

export(float) var SPEED := 1200
export(int) var DAMAGE := 1
export var POTENTIAL := 1

var velocity := Vector2()

func _ready():
	yield($Lifetime, "timeout")
	queue_free()

func shoot(parent_velocity):
	# this ensures the bullet doesnt lose speed, but is also affected by parent's velocity.
	var my_dir := Vector2(1, 0).rotated(rotation)
	var rejection = parent_velocity.slide(my_dir)
	velocity = (my_dir * SPEED + rejection).normalized() * SPEED

func _physics_process(delta):
	var collision := move_and_collide(velocity * delta)
	if collision:
		queue_free() 

func apply_mods(params: Dictionary, area: Area2D):
	for mod in $Mods.get_children():
		mod.apply(params, area)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	var params = {
		potential = POTENTIAL,
		direction = velocity.normalized()
	}
	apply_mods(params, area)
	queue_free()
