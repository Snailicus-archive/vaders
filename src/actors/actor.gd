extends KinematicBody2D
class_name Actor

signal died

export(int, 1, 300) var MAX_HP := 3


var stats := {
	position = self.global_position,
	velocity = Vector2.ZERO,
	max_hp = MAX_HP,
	hp = MAX_HP,
} setget , get_stats

onready var status_effects = $StatusEffects

func get_stats():
	stats['position'] = self.global_position
	return stats

func _ready() -> void:
	stats["status_effects"] = $StatusEffects

func add_status_effect(effect: Node):
	$StatusEffects.add_child(effect)

func move(delta):
	pass

func take_damage(damage: int) -> void:
	stats.hp -= damage
	if stats.hp <= 0:
		kill()

func take_force(force: Vector2) -> void:
	stats.velocity += force

func kill():
	emit_signal('died')
	queue_free()
