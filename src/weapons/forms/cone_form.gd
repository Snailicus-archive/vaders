extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

func action(from, direction):
	$Model.frame = 0
	$Model.play()

	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_position = from
	p.global_rotation = direction
	emit_signal("emitted_projectile", p)
