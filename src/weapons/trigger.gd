extends Node

onready var cooldown = $Timer

var stats: Dictionary
var action: FuncRef

func trigger():
	if cooldown.is_stopped():
		action.call_func(stats)
		cooldown.start()
	cooldown.one_shot = false

func release():
	cooldown.one_shot = true

func _on_Timer_timeout() -> void:
	print('wew')
	if not cooldown.one_shot:
		action.call_func(stats)
