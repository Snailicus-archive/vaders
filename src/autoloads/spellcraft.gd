extends Node

const BASE_EFFECTS := EffectsIndex.INDEX
var effects := {} # name -> Effect

func add_effect(name: String, base_name: String, _effects: Array) -> void:
	if not base_name in BASE_EFFECTS:
		push_error("base_effect not found: %s" % base_name)
	var new_effect = Effect.new()
	new_effect.NAME = name
	new_effect.BASE_EFFECT = BASE_EFFECTS[base_name][1]

	new_effect.EFFECTS = []
	for eff in _effects:
		new_effect.EFFECTS.append(effects[eff])

	effects[name] = new_effect
	print("new effect: ", name)

static func apply_effect(target: Actor, effect: Effect, stats: Dictionary):
	var effect_inst = effect.create()
	effect_inst.target = target
	target.add_status_effect(effect_inst)
	effect_inst.init(stats)

#	ResourceSaver.save( # saving the new spell
#			'res://saved_content/spell_' + new_effect.NAME,
#			new_effect)

#func set_effects(val) -> void:
#	if BASE_EFFECT.REQ == NAN:
#		pass
#	elif BASE_EFFECT.REQ < 0:
#		if not len(EFFECTS) >= abs(BASE_EFFECT.REQ):
#			push_error("DIFFERENTLY WRONG")
#	elif BASE_EFFECT.REQ >= 0:
#		if len(EFFECTS) != BASE_EFFECT.REQ:
#			push_error("WRONG!")
#	EFFECTS = val
