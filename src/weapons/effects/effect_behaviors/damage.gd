extends EffectBehavior

class_name BehaviorDamage

const REQ := 1
const SCENE := preload('damage.tscn')

func start():
	parent.take_damage(meta_params['damage'] * stats['intensity'])
	queue_free()
