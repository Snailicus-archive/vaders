extends KinematicBody2D

export(float) var SPEED := 1200
export(int) var DAMAGE := 1

var velocity := Vector2()
var stats

func _ready():
	yield($Lifetime, "timeout")
	queue_free()

func init(_stats):
	# this ensures the bullet doesnt lose speed, but is also affected by parent's velocity.
	stats = _stats.duplicate()
	var parent_velocity = stats.velocity

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
	var _stats = stats.duplicate()
	_stats['direction'] = velocity.normalized()

	apply_sigils(_stats, area.get_parent())
	queue_free()
