extends Reference
class_name EffectsIndex

# keeps an index of all the existing basic effect behaviors,
# their required parameters, effects, and names them.
# this is basically an abstract representation of how the user
# should see them when creating a new spell.


# name -> [input_effects, base_scene]
const INDEX := {
	'Damage': [0, preload("base_effects/damage.tscn")],
	'Force': [0, preload("base_effects/force.tscn")],
	'Reapply': [1, preload("base_effects/reapply.tscn")],
	'Composite': [2, preload("base_effects/composite.tscn")]
}
