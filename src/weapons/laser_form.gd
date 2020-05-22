extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(Array, PackedScene) var mods

var direction: Vector2

func action(from, to):
	var p = PROJECTILE.instance()
	for mod in mods:
		p.get_node('Mods').add_child(mod.instance())
	p.global_position = from
	p.global_rotation = (to - from).angle()
	p.shoot((to - from).length())
	emit_signal("emitted_projectile", p)
