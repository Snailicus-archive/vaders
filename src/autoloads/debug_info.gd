extends CanvasLayer

var stats = []

onready var label = $Label

func add_stat(name: String, obj: Node, ref: String, is_method: bool) -> void:
	stats.append({
		name=name,
		obj=obj,
		ref=ref,
		is_method=is_method
		})

func _process(delta: float) -> void:
	var label_text = ""
	var value = ""
	for s in stats:
		if is_instance_valid(s.obj):
			if s.is_method:
				value = s.obj.call(s.ref)
			else:
				value = s.obj.get(s.ref)
			label_text += "%s: %s\n" % [s.name, value]
	label.text = label_text
