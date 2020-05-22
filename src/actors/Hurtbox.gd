extends Area2D

signal took_damage(damage)
signal took_force(force)

func take_damage(damage: int):
	emit_signal('took_damage', damage)

func take_force(force: Vector2):
	emit_signal('took_force', force)
