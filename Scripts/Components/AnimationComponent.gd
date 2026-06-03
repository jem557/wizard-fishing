extends AnimatedSprite2D
class_name AnimationComponent

var body

func initialize(pbody):
	body = pbody

func flip() -> void:
	if body:
		if body.velocity.x > 0:
			flip_h = false
		elif body.velocity.x < 0:
			flip_h = true
