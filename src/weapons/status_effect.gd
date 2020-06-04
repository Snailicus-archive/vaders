extends Node

onready var parent = get_parent()

func take_damage(damage: int) -> void:
	parent.stats.hp -= damage
	if parent.stats.hp <= 0:
		parent.kill()

func take_force(force: Vector2) -> void:
	parent.stats.velocity += force
