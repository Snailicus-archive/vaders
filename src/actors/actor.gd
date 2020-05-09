extends KinematicBody2D

export(int, 1, 300) var hp := 3

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		kill()

func kill():
	queue_free()
