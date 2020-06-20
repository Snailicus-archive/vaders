extends Node2D

class_name EffectBehavior

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
