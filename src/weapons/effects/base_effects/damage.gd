extends BaseEffect

export(float) var DAMAGE = 1.0

func start():
	target.take_damage(DAMAGE * stats['intensity'])
	queue_free()
