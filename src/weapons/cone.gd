extends Node2D

export var DAMAGE := 1
export var LIFETIME := 0.1

func _ready() -> void:
	$Model.play()
	yield($Model, "animation_finished")
	queue_free()

func _on_Hitbox_area_entered(area: Area2D) -> void:
	area.take_damage(DAMAGE)
