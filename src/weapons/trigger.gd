extends Node

onready var cooldown = $Timer
var action: FuncRef


func trigger():
	if cooldown.is_stopped():
		action.call_func()
		cooldown.start()
	cooldown.one_shot = false

func release():
	cooldown.one_shot = true

func _on_Cooldown_timeout():
	if not cooldown.one_shot:
		action.call_func()
