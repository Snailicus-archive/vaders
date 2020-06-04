extends StatusEffect

export(int) var FORCE = 100

func start():
	parent.take_force(FORCE)
