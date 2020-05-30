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
	$Model.frame = 0
	$Model.play()

	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_position = $Muzzle.global_position
	p.global_rotation = global_rotation
	p.init(stats)
	emit_signal("emitted_projectile", p)
