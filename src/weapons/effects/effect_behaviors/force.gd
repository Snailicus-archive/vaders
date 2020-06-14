extends EffectBehavior

class_name BehaviorForce

const REQ := 1
const SCENE := preload('force.tscn')

export(int) var FORCE = 100

func start():
	parent.take_force(FORCE)
