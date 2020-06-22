extends Resource

class_name Effect

export(String) var NAME
# BUG #30694, should be BaseEffect
export(PackedScene) var BASE_EFFECT
export(Array) var EFFECTS

func create():
	# creates a new effect from the effect behavior base effect, and inits it.
	var eff = BASE_EFFECT.instance()
	eff.child_effects = EFFECTS
	return eff
