extends Node2D

class_name StatusEffect
# parent must be set
# start() needs to be overriden by each status effect
# meta_params are global parameters that every similar status effect has
# stats are per-instance parameters


var parent: Node
var meta_params: Dictionary setget set_meta_params
var stats: Dictionary setget init

func set_meta_params(params: Dictionary) -> void:
	meta_params = params

func init(params: Dictionary):
	stats = params
	start()

func start():
	pass
