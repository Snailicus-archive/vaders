extends KinematicBody2D

signal died

export(int, 1, 300) var hp := 3

func _ready() -> void:
	$Hurtbox.connect('took_damage', self, '_on_damaged')

func _on_damaged(damage):
	hp -= damage
	if hp <= 0:
		kill()

func kill():
	emit_signal('died')
	queue_free()
