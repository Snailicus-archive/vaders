extends KinematicBody2D

signal died

export(int, 1, 300) var MAX_HP := 3

var stats := {
	position = self.global_position,
	velocity = Vector2.ZERO,
	max_hp = MAX_HP,
	hp = MAX_HP,
} setget , get_stats

func get_stats():
	stats['position'] = self.global_position
	return stats

func _ready() -> void:
	stats["status_effects"] = $StatusEffects

func add_status_effect(effect: Node):
	stats.status_effects.add_child(effect)

func move(delta):
	pass

func kill():
	emit_signal('died')
	queue_free()
