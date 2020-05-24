extends Node2D

export(float) var COOLDOWN := 0.5
export(int) var DAMAGE := 1

var parent: Node
var aim_point = Vector2.ZERO setget ,get_aim_point
var active_form: Node
var cooldown_mod := 1.0
var damage_mod := 1

onready var cooldown = $Cooldown
onready var forms = $Forms

func _ready():
	for form in forms.get_children():
		form.hide()
	cooldown.wait_time = COOLDOWN * cooldown_mod
	print(cooldown.wait_time)
	change_form('Laser')

func trigger():
	if cooldown.is_stopped():
		fire()
		cooldown.start()
	cooldown.one_shot = false

func release():
	cooldown.one_shot = true

func change_form(name: String):
	var f = forms.get_node(name)
	if active_form == f:
		return

	if active_form:
		active_form.hide()

	active_form = f
	active_form.show()

func _on_Cooldown_timeout():
	if not cooldown.one_shot:
		fire()

func fire():
	match active_form.name:
		'Cone':
			cone_attack()
		'Bullet':
			bullet_attack()
		'Laser':
			laser_attack()
		_:
			print('Either melee or bullet must be active.')

func attack():
	pass

func cone_attack():
	active_form.action(self.global_position, self.global_rotation)

func bullet_attack():
	var parent_velocity = parent.velocity if parent else Vector2.ZERO
	active_form.action(self.global_position, self.global_rotation, parent_velocity)

func laser_attack():
	active_form.action(self.global_position, self.aim_point)

func get_aim_point() -> Vector2:
	var maxdist = Vector2.RIGHT * 10000
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position,
		(global_position + maxdist).rotated(global_rotation), [], 1)

	if result:
		return result.position
	else:
		return global_position + maxdist
