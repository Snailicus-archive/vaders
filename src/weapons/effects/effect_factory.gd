extends Resource

class_name EffectFactory

export(String) var NAME
# BUG #30694, should be EffectBehavior
export(PackedScene) var EFFECT_BEHAVIOR
export(Array) var EFFECTS

func instance():
	var eff = EFFECT_BEHAVIOR.instance()
	eff.child_effects = EFFECTS
	return eff
