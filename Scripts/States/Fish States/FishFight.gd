extends State

var h_body : hook
var resting : bool

var stamina
var fish_str
var player_str

func Enter():
	h_body = attachment.attached_body
	movement.rotation_offset = 0

func Physics_Update(_delta: float):
	if c_body.stats.stamina > 0  and not resting and c_body.stats.str > h_body.p_stats.str:
		movement.move(_delta)
	elif c_body.stats.stamina <= 0:
		resting = true
		stamina += 1 * _delta
		c_body.rest()
	
