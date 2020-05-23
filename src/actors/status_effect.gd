extends Node

onready var parent = get_parent()

func take_damage(damage: int) -> void:
	parent.hp -= damage
	if parent.hp <= 0:
		parent.kill()

func take_force(force: Vector2) -> void:
	parent.velocity += force
