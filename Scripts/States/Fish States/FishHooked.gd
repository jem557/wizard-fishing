extends State
class_name FishHooked

var AP
var H_AP
var hook

func Enter():
	c_body = movement.body
	AP = attachment.active_AP
	H_AP = attachment.attached_AP
	hook = attachment.attached_AC.get_parent()
	detection._toggle_hook_area("area_" + AP.name, false)
	if AP.position.x > 0:
		movement.rotation_offset = -(PI / 2)
	else:
		movement.rotation_offset = (PI / 2)
	c_body.attached = true
func Physics_Update(_delta: float):
	if c_body.attached:
		movement._rotateX(_delta, hook)
		attachment._lock_position(AP, H_AP)
	elif not c_body.attached:
		Transitioned.emit(self, "FishIdle")
