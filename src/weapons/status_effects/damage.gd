extends StatusEffect

func start():
	parent.take_damage(meta_params['damage'] * stats['intensity'])
	queue_free()
