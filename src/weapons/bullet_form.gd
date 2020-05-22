extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(Array, PackedScene) var mods

func action(from, direction, parent_velocity):
	var p = PROJECTILE.instance()
	for mod in mods:
		p.get_node('Mods').add_child(mod.instance())

	p.global_rotation = direction
	p.global_position = from
	p.shoot(parent_velocity)
	emit_signal("emitted_projectile", p)
