extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(float) var INTENSITY = 1

var parent: Node setget set_parent
var stats: Dictionary

onready var trigger = $Trigger

func _ready():
	trigger.action = funcref(self, "action")

func set_parent(val):
	parent = val
	stats = parent.stats.duplicate()
	stats['intensity'] = INTENSITY
	trigger.stats = stats

func trigger():
	print(trigger.stats)
	trigger.trigger()

func release():
	trigger.release()



func action(stats):
	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_rotation = global_rotation
	p.global_position = $Muzzle.global_position
	p.init(stats)
	emit_signal("emitted_projectile", p)
