extends Node2D

signal emitted_projectile(p)

export(PackedScene) var PROJECTILE

var parent: Node
var direction: Vector2

func action():
	var params = parent.stats
	var p = PROJECTILE.instance()
	for sigil in $Sigils.get_children():
		p.get_node('Sigils').add_child(sigil.duplicate(7))

	p.global_position = $Muzzle.global_position
	p.global_rotation = global_rotation
	p.shoot((get_aim_point() - $Muzzle.global_position).length())
	emit_signal("emitted_projectile", p)

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($Muzzle.global_position,
		($Muzzle.global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist
