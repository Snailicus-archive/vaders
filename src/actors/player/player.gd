extends "res://src/actors/actor.gd"

signal died

# TODO: weapon animation with sparkles.

export(float) var max_speed := 900
export(float) var acceleration := 4000
export(float) var turn_speed := 10

onready var velocity := Vector2()
onready var weapon := $Pivot/Offset/Weapon


func _ready():
	weapon.parent = self

func take_damage(x):
	print('ouch')
	.take_damage(x)
func kill():
	emit_signal("died")
	.kill()
	
func _input(event):
	if event.is_action_pressed("fire"):
		weapon.trigger()
	elif event.is_action_released("fire"):
		weapon.release()
	
	if event.is_action_pressed("melee"):
		weapon.flags.melee = not weapon.flags.melee
		weapon.flags.bullet = not weapon.flags.bullet


func get_direction():
	var direction = Vector2()
	if Input.is_action_pressed('right'):
		direction.x += 1
	if Input.is_action_pressed('left'):
		direction.x -= 1
	if Input.is_action_pressed('down'):
		direction.y += 1
	if Input.is_action_pressed('up'):
		direction.y -= 1
	return direction.normalized()

func _physics_process(delta):
	# turning
	var mouse_pos = get_global_mouse_position()
	var turn_target = $Pivot.get_angle_to(mouse_pos)
	if abs(turn_target) < turn_speed * delta:
		$Pivot.rotation += turn_target
	else:
		$Pivot.rotation += sign(turn_target) * turn_speed * delta

	# movement
	var velocity_target = get_direction() * max_speed
	velocity = Movement.approach(velocity, velocity_target, acceleration*delta)

	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider:
			velocity = velocity.slide(collision.normal)



