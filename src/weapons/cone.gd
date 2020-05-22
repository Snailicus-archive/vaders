extends Node2D

export var DAMAGE := 1
export var LIFETIME := 0.1
export var POTENTIAL := 2

func _ready() -> void:
	$Model.play()
	yield($Model, "animation_finished")
	queue_free()

func apply_mods(params: Dictionary, area: Area2D):
	for mod in $Mods.get_children():
		mod.apply(params, area)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	var params = {
		potential = POTENTIAL,
		direction = (area.global_position - self.global_position).normalized(),
	}
	apply_mods(params, area)
