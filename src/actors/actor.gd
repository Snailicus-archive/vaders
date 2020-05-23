extends KinematicBody2D

signal died
export(int, 1, 300) var hp := 3

var velocity := Vector2.ZERO
onready var status_effects = $StatusEffects

func add_status_effect(effect: Node):
	status_effects.add_child(effect)

func move(delta):
	pass

func kill():
	emit_signal('died')
	queue_free()
