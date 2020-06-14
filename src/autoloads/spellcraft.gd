extends Node

var base_effects := {
	'Damage': BehaviorDamage,
	'Force': BehaviorForce,
	'Reapply': BehaviorReapply,
}
var effects := {} # name -> EffectFactory

func add_effect(name: String, base_name: String, effects: Array) -> void:
	var new_effect = EffectFactory.new()
	new_effect.NAME = name
	new_effect.EFFECT_BEHAVIOR = base_effects[base_name]
	new_effect.EFFECTS = effects

	effects[new_effect.NAME] = new_effect
#	ResourceSaver.save( # saving the new spell
#			'res://saved_content/spell_' + new_effect.NAME,
#			new_effect)

static func apply_effect(target: Actor, effect: EffectFactory, stats: Dictionary):
	var effect_inst = effect.instance()
	effect_inst.init(stats)
	target.add_status_effect(effect_inst)
