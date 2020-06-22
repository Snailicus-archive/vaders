extends Actor

export(float) var MAX_SPEED := 900
export(float) var ACCELERATION := 4000
export(float) var TURN_SPEED := 10


var max_speed := MAX_SPEED
var acceleration := ACCELERATION

onready var arsenal := $Pivot/Offset/Arsenal
onready var camera := $CameraPivot/Offset/Camera

func _ready():
	._ready()
	arsenal.parent = self

func _input(event):
	if event.is_action_pressed("next_weapon"):
		arsenal.next_weapon()
	if event.is_action_pressed("prev_weapon"):
		arsenal.prev_weapon()

	if event.is_action_pressed("attack"):
		arsenal.trigger()
	elif event.is_action_released("attack"):
		arsenal.release()

func _physics_process(delta):
	# turning
	var mouse_pos = get_global_mouse_position()
	var turn_target = $Pivot.get_angle_to(mouse_pos)
	if abs(turn_target) < TURN_SPEED * delta:
		$Pivot.rotation += turn_target
	else:
		$Pivot.rotation += sign(turn_target) * TURN_SPEED * delta

	move(delta)

func move(delta):
	var velocity_target = get_direction() * max_speed

	stats.velocity = Movement.approach(stats.velocity,
		velocity_target, acceleration*delta)

	if stats.velocity:
		$Sprite.rotation = stats.velocity.angle() + PI/2

	var collision = move_and_collide(stats.velocity * delta)
	if collision:
		if collision.collider:
			stats.velocity = stats.velocity.slide(collision.normal)

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
	._on_taken_damage(x)
