extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE
export(Array, PackedScene) var mods

func action(from, direction):
	$Model.frame = 0
	$Model.play()

	var p = PROJECTILE.instance()
	for mod in mods:
		p.get_node('Mods').add_child(mod.instance())

	p.global_position = from
	p.global_rotation = direction
	emit_signal("emitted_projectile", p)
