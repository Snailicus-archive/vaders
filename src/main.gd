extends Node

onready var player := $Player
onready var world := $World

func _ready():
	player.weapon.connect("shot", self, "on_Player_shoot")

func on_Player_shoot(projectile:PackedScene, position:Vector2, rotation:float, parent_velocity):
	var p = projectile.instance()
	add_child(p)
	p.rotation = rotation
	p.position = position
	p.shoot(parent_velocity)

func _on_Player_died() -> void:
	pass # Replace with function body.
