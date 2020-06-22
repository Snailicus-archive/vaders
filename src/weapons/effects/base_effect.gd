extends Node2D
class_name BaseEffect

# The base of an effect - encapsulates the actual behavior of the effect.
# It is meant to be parameterized by an Effect object with proper settings.
# Contains all logic related to the inner workings of the effect on the actor.


var target: Node
var child_effects: Array setget set_child_effects

var stats: Dictionary setget init


func set_child_effects(effects):
	child_effects = effects

func init(params: Dictionary):
	stats = params
	start()

func start():
	pass
