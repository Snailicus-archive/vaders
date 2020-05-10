extends Area2D

signal took_damage(damage)

func take_damage(damage: int):
	emit_signal('took_damage', damage)
