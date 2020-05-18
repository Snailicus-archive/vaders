extends KinematicBody2D

export(float) var speed := 1200
export(int) var damage := 1

var velocity := Vector2()

func _ready():
	yield($Lifetime, "timeout")
	queue_free()

func shoot(parent_velocity):
	# this ensures the bullet doesnt lose speed, but is also affected by parent's velocity.
	var my_dir := Vector2(1, 0).rotated(rotation)
	var rejection = parent_velocity.slide(my_dir)
	velocity = (my_dir * speed + rejection).normalized() * speed

func _physics_process(delta):
	var collision := move_and_collide(velocity * delta)
	if collision:
		queue_free() 

func _on_Hitbox_area_entered(area: Area2D) -> void:
	area.take_damage(damage)
	queue_free()
