extends Node

onready var player := $Player
onready var world := $World

func _ready():
	Spellcrafter.add_effect('Damage', 'Damage', [])
	Spellcrafter.add_effect('ForceMe', 'Force', [])
	Spellcrafter.add_effect('Fire', 'Reapply', ['Damage'])
	Spellcrafter.add_effect('Explosion', 'Composite', ['Damage', 'ForceMe'])

	for weapon in get_tree().get_nodes_in_group("ProjectileEmitters"):
		weapon.connect("emitted_projectile", self, "_on_emitted_projectile")


func _on_emitted_projectile(p):
	add_child(p)

func _on_Player_died() -> void:
	pass # Replace with function body.
