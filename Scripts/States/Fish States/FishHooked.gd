extends State
class_name FishHooked

var AP
var H_AP
var _hook

func Enter():
	c_body = movement.body
	AP = attachment.active_AP
	H_AP = attachment.attached_AP
	_hook = attachment.attached_body
	detection._toggle_hook_area("area_" + AP.name, false)
	if AP.position.x > 0:
		movement.rotation_offset = -(PI / 2)
	else:
		movement.rotation_offset = (PI / 2)
	c_body.attached = true
func Physics_Update(_delta: float):
	if c_body.attached:
		movement._rotateX(_delta, _hook)
		attachment._lock_position(AP, H_AP)
	elif not c_body.attached:
		Transitioned.emit(self, "FishSink")
