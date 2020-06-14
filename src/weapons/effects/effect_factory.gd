extends Resource

class_name EffectFactory

export(String) var NAME
# BUG #30694, should be EffectBehavior
export(PackedScene) var EFFECT_BEHAVIOR
export(Array) var EFFECTS setget set_effects
export(int, FLAGS, "hey", "boi") var test = 0

func set_effects(val) -> void:
	if EFFECT_BEHAVIOR.REQ == NAN:
		pass
	elif EFFECT_BEHAVIOR.REQ < 0:
		if not len(EFFECTS) >= abs(EFFECT_BEHAVIOR.REQ):
			push_error("DIFFERENTLY WRONG")
	elif EFFECT_BEHAVIOR.REQ >= 0:
		if len(EFFECTS) != EFFECT_BEHAVIOR.REQ:
			push_error("WRONG!")
	EFFECTS = val


func instance():
	var eff = EFFECT_BEHAVIOR.instance()
	eff.init(EFFECTS)
	return eff
