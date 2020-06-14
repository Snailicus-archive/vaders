extends Line2D

export var DAMAGE := 1
export var LIFETIME := 0.3


var stats: Dictionary

func _ready() -> void:
	yield(get_tree().create_timer(LIFETIME), "timeout")
	queue_free()

func init(_stats):
	stats = _stats.duplicate()

	self.points[1] = Vector2(stats.length, 0)

	$Hitbox/CollisionShape2D.shape.points[0] = Vector2(0, self.width/2)
	$Hitbox/CollisionShape2D.shape.points[1] = Vector2(0, -self.width/2)
	$Hitbox/CollisionShape2D.shape.points[2] = Vector2(stats.length, -self.width/2)
	$Hitbox/CollisionShape2D.shape.points[3] = Vector2(stats.length, self.width/2)

func apply_sigils(params: Dictionary, target: Node):
	for sigil in $Sigils.get_children():
		sigil.apply(params, target)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	var _stats = stats.duplicate()
	apply_sigils(_stats, area.get_parent())
