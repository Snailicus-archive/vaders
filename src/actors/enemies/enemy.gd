extends "res://src/actors/actor.gd"

export(float) var turn_speed = 10
export(float) var max_speed = 400
export(float) var acceleration = 300

var target
var repulsion_force
var repelled = {}

func _physics_process(delta):
	move(delta)

func move(delta):
	var my_dir = Vector2.RIGHT.rotated(rotation)
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		rotation = Movement.turn_to(my_dir, target_dir, turn_speed * delta).angle()
	if repulsion_force and not (target and target.position.distance_to(position) < 300):
		velocity = Movement.approach(velocity, repulsion_force * max_speed, acceleration * delta)
	else:
		if target:
			var velocity_target = Vector2.RIGHT.rotated(rotation) * max_speed
			velocity = Movement.approach(velocity, velocity_target, acceleration * delta)
		else:
			velocity = Movement.approach(velocity, Vector2.ZERO, acceleration * delta)

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)

func _on_Detection_body_entered(body):
	target = body

func _on_Chase_body_exited(body):
	if body == target:
		target = null

func _on_Repulsion_body_entered(body):
	if body == self:
		return
	repelled[body] = body
	var sum = Vector2.ZERO
	for bod in repelled:
		sum += (position - bod.position).normalized()
	repulsion_force = sum

func _on_Repulsion_body_exited(body):
	repelled.erase(body)
	var sum = Vector2.ZERO
	for bod in repelled:
		sum += (position - bod.position).normalized()
	repulsion_force = sum
