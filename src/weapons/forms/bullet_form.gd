extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

func action(from, direction, parent_velocity):
	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_rotation = direction
	p.global_position = from
	p.shoot(parent_velocity)
	emit_signal("emitted_projectile", p)
