extends Reference
class_name EffectsIndex

# keeps an index of all the existing basic effect behaviors,
# their required parameters, effects, and names them.
# this is basically an abstract representation of how the user
# should see them when creating a new spell.


# name -> [input_effects, base_scene]
const INDEX := {
	'Damage': [0, preload("effect_behaviors/damage.tscn")],
	'Force': [0, preload("effect_behaviors/force.tscn")],
	'Reapply': [1, preload("effect_behaviors/reapply.tscn")],
}
