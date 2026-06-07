class_name FishIdle
extends State


var seconds : float

func Enter():
	seconds = randf_range(1.0, 4.0)
	movement.move_dir = Vector2.ZERO

func Physics_Update(_delta: float):
	seconds -= _delta
	if not health.dead:
		if c_body.attached: 
			Transitioned.emit(self, "FishFight")
		else:
			if seconds > 0:
				movement.move(_delta)
				movement._rotateY(_delta, c_body)
			else:
				Transitioned.emit(self, "FishWander")
	else:
		Transitioned.emit(self, "FishDead")
