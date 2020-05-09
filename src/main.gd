extends Node

func _ready():
	$Player.weapon.connect("shot", self, "on_Player_shoot")
# warning-ignore:return_value_discarded
	$Player.connect("died", self, "on_Player_died")
#	$Enemy.target = $Player


func on_Player_died():
#	$Enemy.target = null
	pass

func on_Player_shoot(projectile:PackedScene, position:Vector2, rotation:float, parent_velocity):
	var p = projectile.instance()
	add_child(p)
	p.rotation = rotation
	p.position = position
	p.shoot(parent_velocity)
