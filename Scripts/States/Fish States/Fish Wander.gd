class_name FishWander
extends State


var seconds : float = 0

func Enter():
	seconds = randf_range(2.0, 5.0)

func Physics_Update(_delta: float):
	if not health.dead:
		seconds -= _delta
		if c_body.attached:
			Transitioned.emit(self, "FishFight")
		else:
			if seconds >= 0:
				movement.move_dir = behavior.move_dir
				behavior._roam()
				detection.flip()
				animation.flip()
				movement.move(_delta)
				movement._rotateY(_delta, c_body)
			else:
				Transitioned.emit(self, "FishIdle")
	else: 
		Transitioned.emit(self, "FishDead")
