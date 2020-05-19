extends Node

onready var player := $Player
onready var world := $World

func _ready():
	player.weapon.connect("emit_bullet", self, "_on_Player_bullet_attack")
	player.weapon.connect("emit_laser", self, "_on_Player_laser_attack")

func _on_Player_bullet_attack(p):
	add_child(p)

func _on_Player_laser_attack(p):
	add_child(p)

func _on_Player_died() -> void:
	pass # Replace with function body.
