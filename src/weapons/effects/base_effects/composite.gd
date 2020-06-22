extends BaseEffect

# child_effects: []

func start() -> void:
	for eff in child_effects:
		Spellcrafter.apply_effect(target, eff, stats)
