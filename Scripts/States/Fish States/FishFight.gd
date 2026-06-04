class_name FishFight
extends State

var h_body : hook
var resting : bool

var AP
var H_AP

func Enter():
	c_body = movement.body
	h_body = attachment.attached_body
	AP = attachment.active_AP
	H_AP = attachment.attached_AP
	detection._toggle_hook_area("area_" + AP.name, false)
	movement.rotation_offset = 0
	c_body.attached = true

func Physics_Update(_delta: float):
	if stamina.stamina > 0  and not resting and health._str > h_body.stats.strength:
		h_body.attachment_component._lock_position(H_AP, AP)
		behavior._roam()
		movement._rotateY(_delta)
		movement.move(_delta)
		animation.flip()
		stamina.drain(_delta)
	elif stamina.stamina <= 0:
		resting = true
	if resting:
		h_body.attachment_component._lock_position(H_AP, AP)
		stamina.rest(_delta)
	if stamina.stamina >= stamina.max_stamina:
		resting = false
