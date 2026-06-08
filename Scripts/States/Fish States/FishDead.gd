class_name FishDead
extends State


var AP
var H_AP
var h_body

func Enter():
	if c_body.attached:
		c_body = movement.body
		AP = attachment.active_AP
		H_AP = attachment.attached_AP
		h_body = attachment.attached_body
		detection._toggle_hook_area("area_" + AP.name, false)
		if AP.position.x > 0:
			movement.rotation_offset = -(PI / 2)
		else:
			movement.rotation_offset = (PI / 2)
func Physics_Update(_delta: float):
	if c_body.attached:
		movement._rotateX(_delta, h_body)
		attachment._lock_position(AP, H_AP)
	elif not c_body.attached:
		#detection._toggle_hook_area("area_" + AP.name, true)
		Transitioned.emit(self, "FishSink")
