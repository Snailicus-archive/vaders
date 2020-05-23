extends Node

const STATUS_EFFECT = preload("res://src/weapons/status_effects/reapplied.tscn")

var parent = self.get_parent()

func apply(params: Dictionary, n: Node):
	var effect = STATUS_EFFECT.instance()
	for sigil in $Sigils.get_children():
		effect.get_node('Sigils').add_child(sigil.duplicate(7))
	n.add_status_effect(effect)
