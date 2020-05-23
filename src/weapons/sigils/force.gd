extends Node

const STATUS_EFFECT = preload("res://src/weapons/status_effects/forced.tscn")
export var FORCE := 300

var parent = self.get_parent()

func apply(params: Dictionary, n: Node):
	var effect = STATUS_EFFECT.instance()
	effect.init(params.direction * params.intensity * FORCE)
	n.add_status_effect(effect)
