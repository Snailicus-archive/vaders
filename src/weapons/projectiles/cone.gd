extends Node2D

export var DAMAGE := 1
export var LIFETIME := 0.1

var stats: Dictionary

func _ready() -> void:
	$Model.play()
	yield($Model, "animation_finished")
	queue_free()

func init(_stats):
	stats = _stats.duplicate()

func apply_sigils(params: Dictionary, target: Node):
	for sigil in $Sigils.get_children():
		sigil.apply(params, target)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	var _stats = stats.duplicate()
	_stats['direction'] = _stats.velocity.normalized()

	apply_sigils(_stats, area.get_parent())
