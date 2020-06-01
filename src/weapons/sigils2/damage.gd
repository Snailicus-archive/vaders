extends "res://src/weapons/sigils2/status_effect.gd"


func _ready() -> void:
	required_init_params = ['damage']
	required_stats = ['intensity']

func start(stats):
	.start(stats)
	parent.take_damage(init_params['damage'] * stats['intensity'])
