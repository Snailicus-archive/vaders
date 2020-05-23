extends Node2D

export var DAMAGE := 1
export var LIFETIME := 0.1
export var INTENSITY := 2

func _ready() -> void:
	$Model.play()
	yield($Model, "animation_finished")
	queue_free()

func apply_sigils(params: Dictionary, target: Node):
	for sigil in $Sigils.get_children():
		sigil.apply(params, target)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	var params = {
		intensity = INTENSITY,
		direction = (area.global_position - self.global_position).normalized(),
	}
	apply_sigils(params, area.get_parent())
