extends Node

export var FORCE := 300

var parent = self.get_parent()

func apply(params: Dictionary, n: Node):
	n.take_force(params.direction * params.potential * FORCE)
