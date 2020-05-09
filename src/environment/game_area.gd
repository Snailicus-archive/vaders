extends Area2D

func _on_GameArea_body_exited(body):
	if body.has_method("kill"):
		body.kill()
	else:
		body.queue_free()
