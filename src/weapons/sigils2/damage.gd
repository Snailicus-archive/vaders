extends "res://src/weapons/sigils2/status_effect.gd"

func start():
	parent.take_damage(meta_params['damage'] * stats['intensity'])
	queue_free()
