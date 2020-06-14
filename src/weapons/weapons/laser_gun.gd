extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(float) var INTENSITY = 1

var parent: Node setget set_parent
var stats: Dictionary

onready var trigger = $Trigger

func _ready() -> void:
	trigger.action = funcref(self, "action")
	trigger.stats = stats

func set_parent(val):
	parent = val
	stats = parent.stats.duplicate()
	stats['intensity'] = INTENSITY
	trigger.stats = stats

func trigger():
	trigger.trigger()

func release():
	trigger.release()

func action(stats):
	var _stats = stats.duplicate()
	_stats['length'] = (get_aim_point() - $Muzzle.global_position).length()

	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_position = $Muzzle.global_position
	p.global_rotation = global_rotation
	p.init(_stats)
	emit_signal("emitted_projectile", p)

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($Muzzle.global_position,
		($Muzzle.global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist
