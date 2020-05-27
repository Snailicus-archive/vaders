extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

var direction: Vector2

#func action(from, to):
#	var p = PROJECTILE.instance()
#	for sigil in $Sigils.get_children():
#		p.get_node('Sigils').add_child(sigil.duplicate(7))
#
#	p.global_position = from
#	p.global_rotation = (to - from).angle()
#	p.shoot((to - from).length())
#	emit_signal("emitted_projectile", p)

func action(params):
	var p = PROJECTILE.instance()
	for sigil in params["sigils"]:
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_position = params["from"]
	p.global_rotation = (params["to"] - params["from"]).angle()
	p.shoot((params["to"] - params["from"]).length())
	emit_signal("emitted_projectile", p)
