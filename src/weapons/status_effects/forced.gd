extends Node

var force: Vector2
var params: Dictionary

func init(force: Vector2) -> void:
	self.force = force

func _ready() -> void:
	get_parent().take_force(force)
