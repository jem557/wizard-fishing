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
	if not health.dead:
		movement.move_dir = behavior.move_dir
		if stamina.stamina > 0  and not resting and health._str > h_body.stats.strength:
			behavior._roam()
			movement._rotateY(_delta, c_body)
			movement.hooked_move(health._str, h_body.stats.strength, h_body,_delta)
			animation.attached_flip(c_body ,AP)
			stamina.drain(_delta)
			h_body.attachment_component._lock_position(H_AP, AP)
		elif stamina.stamina <= 0:
			resting = true
		if resting || health._str < h_body.stats.strength:
			animation.attached_flip(h_body ,AP)
			c_body.attachment_component._lock_position(AP, H_AP)
			movement._rotateY(_delta,h_body)
			stamina.rest(_delta)
			if stamina.stamina >= stamina.max_stamina:
				resting = false
	else:
		animation.reset_flip()
		Transitioned.emit(self, "FishDead")
	
