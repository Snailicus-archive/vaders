extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

var parent: Node

func _ready() -> void:
	$Trigger.action = funcref(self, "action")

func action():
	var params = parent.stats
	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_rotation = global_rotation
	p.global_position = $Muzzle.global_position
	p.shoot(params.velocity)
	emit_signal("emitted_projectile", p)
