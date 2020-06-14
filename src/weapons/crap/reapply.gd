extends Node

export var intensity := 1
export var interval := 0.2
export var intensity_per_tick := 1
export var ticks := 3

var current_tick = 0
var params: Dictionary setget set_params

onready var target: Node = get_parent().parent

func set_params(val):
	params = val


func _ready() -> void:
	$Ticks.wait_time = interval

func init(params: Dictionary):
	self.params = params


func apply_sigils(params: Dictionary, target: Node):
	for effect in params['effects']:
		var inst = Spellcrafter.instance_effect(effect)
#		inst.init(something)
#		var inst = effect.instance() as Node
		inst.init(params)
		target.add_status_effect(inst)


func _on_Ticks_timeout() -> void:
	if current_tick < ticks:
		current_tick += 1
		var params = {
			intensity = intensity * intensity_per_tick,
		}
		apply_sigils(params, target)
	else:
		queue_free()
