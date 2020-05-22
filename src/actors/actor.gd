extends KinematicBody2D

signal died
export(int, 1, 300) var hp := 3

var velocity := Vector2.ZERO

func _ready() -> void:
	$Hurtbox.connect('took_damage', self, '_on_taken_damage')
	$Hurtbox.connect('took_force', self, '_on_taken_force')

func move(delta):
	pass

func _on_taken_damage(damage: int):
	hp -= damage
	if hp <= 0:
		kill()

func _on_taken_force(force: Vector2):
	velocity += force

func kill():
	emit_signal('died')
	queue_free()
