extends Node2D

export var INTENSITY := 1
var mods: Array
var in_range = []

func apply_sigils(params: Dictionary, area: Area2D):
	for sigil in $Sigils.get_children():
		sigil.apply(params, area)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	in_range.append(area)
#	var params = {
#		intensity = INTENSITY,
#	}
#	apply_mods(params, area)

func _on_Hitbox_area_exited(area: Area2d) -> void:
	pass
