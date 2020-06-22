extends BaseEffect

export(int) var FORCE = 1000

func start():
	target.take_force(FORCE * stats['direction'])
