extends Node2D

var attacking := false

func _physics_process(delta: float) -> void:
	if not attacking:
		$End.position = Vector2.ZERO
	elif $RayCast2D.is_colliding():
		$End.global_position = $RayCast2D.get_collision_point()
	else:
		$End.global_position = $RayCast2D.cast_to

	$Body.region_rect.end.x = $End.position.length()
	$LaserHitBox/CollisionShape2D.shape.b.x = $End.position.length()
