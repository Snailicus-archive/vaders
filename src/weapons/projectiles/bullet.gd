extends KinematicBody2D

export(float) var SPEED := 1200
export(int) var DAMAGE := 1
export var INTENSITY := 1

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

func apply_sigils(params: Dictionary, target: Node):
	for sigil in $Sigils.get_children():
		sigil.apply(params, target)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	var params = {
		intensity = INTENSITY,
		direction = velocity.normalized()
	}
	apply_sigils(params, area.get_parent())
	queue_free()
