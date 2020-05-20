extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

func action(from, to):
	var p = PROJECTILE.instance()
	p.global_position = from
	p.global_rotation = (to - from).angle()
	p.shoot((to - from).length())
	emit_signal("emitted_projectile", p)
