class_name Steering

static func approach(from:Vector2, to:Vector2, by:float) -> Vector2:
	var delta = to - from
	if delta.length() <= by:
		return to
	else:
		return from + delta.normalized() * by

static func approach_float(from:float, to:float, by:float) -> float:
	var delta = to - from
	if abs(delta) <= by:
		return to
	else:
		return from + sign(delta) * by

static func turn_to(from:Vector2, to:Vector2, by:float) -> Vector2:
	var delta = from.angle_to(to)
	if abs(delta) <= by:
		return to
	else:
		return from.rotated(sign(delta) * by)
