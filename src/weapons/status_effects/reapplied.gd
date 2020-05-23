extends Node

var intensity := 1
var current_tick = 0

export var interval := 0.2
export var ticks := 3
export var intensity_per_tick := 1

onready var target: Node = get_parent().parent

func _ready() -> void:
	$Ticks.wait_time = interval

func init(intensity: float):
	self.intensity = intensity

func apply_sigils(params: Dictionary, target: Node):
	for sigil in $Sigils.get_children():
		sigil.apply(params, target)

func _on_Ticks_timeout() -> void:
	if current_tick < ticks:
		current_tick += 1
		var params = {
			intensity = intensity * intensity_per_tick,
		}
		apply_sigils(params, target)
	else:
		queue_free()
