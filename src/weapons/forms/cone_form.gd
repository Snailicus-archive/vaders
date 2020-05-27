extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

var parent: Node

func action():
	var params = parent.stats
	$Model.frame = 0
	$Model.play()

	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_position = $Muzzle.global_position
	p.global_rotation = global_rotation
	emit_signal("emitted_projectile", p)
