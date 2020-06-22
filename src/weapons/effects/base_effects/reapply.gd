extends BaseEffect

export(int) var AMOUNT = 3
export(float) var WAIT_TIME = 1
export(float) var INTENSITY_PER_TICK = 1

var current_tick = 0
var effect

func set_child_effects(new):
	.set_child_effects(new)
	effect = child_effects[0]

func _ready() -> void:
	$Timer.connect("timeout", self, '_on_timeout')
	$Timer.wait_time = WAIT_TIME


func start():
	$Timer.start()

func apply_sigils(stats: Dictionary, target: Node):
	for effect in child_effects:
		Spellcrafter.apply_effect(target, effect, stats)

func _on_timeout() -> void:
	if current_tick < AMOUNT:
		current_tick += 1

		var child_stats = {
			'intensity': stats['intensity'] * INTENSITY_PER_TICK,
		}
		Spellcrafter.apply_effect(target, child_effects[0], stats)
		apply_sigils(child_stats, target)
	else:
		queue_free()

