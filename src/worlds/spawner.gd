extends Node2D

const ENEMY = preload("res://src/actors/enemies/enemy.tscn")

onready var spawn_point = $SpawnPoint.global_position

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	var enemy = ENEMY.instance()
	var offset = Vector2.RIGHT.rotated(rand_range(0.0, 2 * PI)) * 300
	enemy.global_position = spawn_point + offset
	get_parent().add_child(enemy)
