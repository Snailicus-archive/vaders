extends Node

export var DAMAGE := 1

var parent = self.get_parent()

func apply(params: Dictionary, n: Node):
	n.take_damage(params.potential * DAMAGE)
