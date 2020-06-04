extends StatusEffect

var current_tick = 0

func start():
	$Timer.start()

func apply_sigils(params: Dictionary, target: Node):
	for effect in params['effects']:
		var inst = Spellcrafter.instance_effect(effect)
		inst.init(params)
		target.add_status_effect(inst)


func _on_Ticks_timeout() -> void:
	if current_tick < meta_params['time_ticks']:
		current_tick += 1

		var child_params = {
			'intensity': stats['intensity'] * meta_params['intensity_per_tick'],
		}
		apply_sigils(child_params, parent)
	else:
		queue_free()
