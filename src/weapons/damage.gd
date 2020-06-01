extends Resource

class_name DamageSigil

export var DAMAGE: int

func _init(parent) -> void:
	parent.take_damage(DAMAGE)

