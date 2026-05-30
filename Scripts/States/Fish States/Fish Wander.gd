extends State
class_name FishWander

var seconds : float = 0

func Enter():
	seconds = randf_range(2.0, 5.0)

func Physics_Update(_delta: float):
	seconds -= _delta
	if attachment.attached:
		Transitioned.emit(self, "FishHooked")
	else:
		if seconds >= 0:
			movement.move_dir = behavior.move_dir
			behavior._roam()
			movement._flip(detection)
			movement.move(_delta)
			movement._rotateY(_delta)
		else:
			Transitioned.emit(self, "FishIdle")
