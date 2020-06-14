extends Weapon

func action(stats):
	$Model.frame = 0
	$Model.play()
	.action(stats)
