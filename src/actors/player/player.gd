extends "res://src/actors/actor.gd"

# TODO: proper testing level(with bounds and enemy zoo)
# TODO: empower
# TODO: bounce
# TODO: implement new weapon scheme
# REFACTOR: animations with animation tree
# TODO: aggro for enemies, so they wont stand still when you hit them


export(float) var MAX_SPEED := 900
export(float) var ACCELERATION := 4000
export(float) var TURN_SPEED := 10
export(float) var DASH_SPEED := 2200

var locked := false setget set_locked

var max_speed := MAX_SPEED
var acceleration := ACCELERATION
var velocity := Vector2.ZERO

onready var dash_velocity := Vector2.ZERO
onready var weapon := $Pivot/Offset/Weapon
onready var camera := $CameraPivot/Offset/Camera

func _ready():
	weapon.parent = self
	weapon.change_weapon("bullet")

func _input(event):
	if event.is_action_pressed("slot3"):
		weapon.change_weapon("laser")
	
#	if event.is_action_pressed("ui_accept"):
#		dash(velocity.normalized())
	if event.is_action_pressed("attack"):
		weapon.trigger()
	elif event.is_action_released("attack"):
		weapon.release()

	if event.is_action_pressed("slot2"):
		weapon.change_weapon("melee")

	if event.is_action_pressed("slot1"):
		weapon.change_weapon("bullet")

func _physics_process(delta):
	# turning
	var mouse_pos = get_global_mouse_position()
	var turn_target = $Pivot.get_angle_to(mouse_pos)
	if not locked:
		if abs(turn_target) < TURN_SPEED * delta:
			$Pivot.rotation += turn_target
		else:
			$Pivot.rotation += sign(turn_target) * TURN_SPEED * delta

	# movement
	var velocity_target = get_direction() * max_speed
	if dash_velocity:
		velocity_target = dash_velocity

	velocity = Movement.approach(velocity, 
		velocity_target, acceleration*delta)

	if velocity:
		$Sprite.rotation = velocity.angle() + PI/2

	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider:
			velocity = velocity.slide(collision.normal)

func dash(direction):
	max_speed = DASH_SPEED
	acceleration = max_speed * 8
	yield(get_tree().create_timer(0.05), "timeout")
	max_speed = MAX_SPEED
	acceleration = ACCELERATION

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

func _on_taken_damage(x):
	print('ouch')
	._on_taken_damage(x)

func set_locked(_locked):
	print(_locked)
	weapon.locked = _locked
	locked = _locked
