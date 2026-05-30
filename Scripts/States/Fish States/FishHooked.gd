extends State
class_name FishHooked

var hooked : bool
var AP
var H_AP
var hook

func Enter():
	AP = attachment.active_AP
	H_AP = attachment.attached_AP
	hook = H_AP.get_parent()
	detection._toggle_hook_area("area_" + AP.name, false)
	if AP.position.x > 0:
		movement.rotation_offset = -(PI / 2)
	else:
		movement.rotation_offset = (PI / 2)
	hooked = true

func Physics_Update(_delta: float):
	if hooked:
		movement._rotateX(_delta, hook)
		attachment._lock_position(AP, H_AP)
	elif not hooked:
		Transitioned.emit(self, "FishIdle")
