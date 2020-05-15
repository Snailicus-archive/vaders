extends Node2D

var attacking := false

func set_size(length):
	$Body.region_rect.end.x = length
	$LaserHitBox/CollisionShape2D.shape.points[2].x = length
	$LaserHitBox/CollisionShape2D.shape.points[3].x = length

func set_attack(val):
	if val:
		set_physics_process(true)
		_physics_process(0)
	else:
		set_size(0)
		set_physics_process(false)
		
	attacking = val
		

func _physics_process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		$End.global_position = $RayCast2D.get_collision_point()
	else:
		$End.global_position = $RayCast2D.cast_to
	
	set_size($End.position.length())
