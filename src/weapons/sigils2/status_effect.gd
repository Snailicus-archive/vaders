extends Node2D

var parent: Node

var required_init_params := []
var init_params: Dictionary setget init

var required_stats := []
var stats: Dictionary setget start


func init(params: Dictionary) -> void:
	init_params = params
	for required_param in required_init_params:
		assert(required_param in init_params)

func start(_stats: Dictionary):
	stats = _stats
	for required_stat in required_stats:
		assert(required_stat in stats)

