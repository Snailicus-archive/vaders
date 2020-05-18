extends Line2D

export var DAMAGE := 1
export var LIFETIME := 0.3

func _ready() -> void:
	yield(get_tree().create_timer(LIFETIME), "timeout")
	queue_free()

func shoot(length: float):
	self.points[1] = Vector2(length, 0)
	
	$Hitbox/CollisionShape2D.shape.points[0] = Vector2(0,self.width/2)
	$Hitbox/CollisionShape2D.shape.points[1] = Vector2(0,-self.width/2)
	$Hitbox/CollisionShape2D.shape.points[2] = Vector2(length,-self.width/2)
	$Hitbox/CollisionShape2D.shape.points[3] = Vector2(length,self.width/2)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	area.take_damage(DAMAGE)
