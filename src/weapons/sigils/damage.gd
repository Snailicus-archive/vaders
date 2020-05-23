extends Node

export var DAMAGE := 1
const STATUS_EFFECT = preload("res://src/weapons/status_effects/damaged.tscn")
var parent = self.get_parent()

func apply(params: Dictionary, n: Node):
	var effect = STATUS_EFFECT.instance()
	effect.init(params.intensity * DAMAGE)
	n.add_status_effect(effect)
