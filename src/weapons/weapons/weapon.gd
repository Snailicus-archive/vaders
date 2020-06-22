extends Node2D
class_name Weapon

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(String) var EFFECT
export(PackedScene) var TRIGGER


export(float) var INTENSITY = 1

var parent: Node setget set_parent
var stats: Dictionary
var trigger_node: Node

func _ready():
	trigger_node = TRIGGER.instance()
	add_child(trigger_node)
	trigger_node.action = funcref(self, "action")

func set_parent(val):
	parent = val
	stats = parent.stats.duplicate()
	stats['intensity'] = INTENSITY
	trigger_node.stats = stats

func trigger():
	trigger_node.trigger()

func release():
	trigger_node.release()

func action(_stats):
	var effect = EFFECT
	var p = PROJECTILE.instance()

	p.global_rotation = global_rotation
	p.global_position = $Muzzle.global_position
	p.EFFECT = Spellcrafter.effects[effect]
	p.init(_stats)
	emit_signal("emitted_projectile", p)
