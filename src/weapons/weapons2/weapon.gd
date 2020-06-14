extends Node2D
class_name Weapon

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(String) var EFFECT
export(PackedScene) var TRIGGER


export(float) var INTENSITY = 1

var parent: Node setget set_parent
var stats: Dictionary
var trigger: Node
var Effect: EffectFactory

func _ready():
	trigger = TRIGGER.instance()
	add_child(trigger)
	trigger.action = funcref(self, "action")
	Effect = Spellcrafter.effects[EFFECT]

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
	var effect = EFFECT
	var p = PROJECTILE.instance()

	p.global_rotation = global_rotation
	p.global_position = $Muzzle.global_position
	p.init(stats, effect)
	emit_signal("emitted_projectile", p)
