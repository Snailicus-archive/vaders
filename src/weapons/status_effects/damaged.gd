extends Node

var damage: int

func init(damage):
	self.damage = damage

func _ready() -> void:
	get_parent().take_damage(damage)
	queue_free()
