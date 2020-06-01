extends Node


# name -> effect
var effects := {}


func add_effect(name: String, base: PackedScene, params: Dictionary):
	assert(not name in effects)

	var effect = {
		'name': name,
		'base': base,
		'params': params,
	}
	effects[name] = effect

func instance_effect(name):
	assert(name in effects)

	var e = effects[name]
	var inst = e.base.instance()
	inst.init(e.params)
	return inst
