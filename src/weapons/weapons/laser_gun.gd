extends Weapon

func action(stats):
	var _stats = stats.duplicate()
	_stats['length'] = (get_aim_point() - $Muzzle.global_position).length()
	.action(_stats)

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray($Muzzle.global_position,
		($Muzzle.global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist
