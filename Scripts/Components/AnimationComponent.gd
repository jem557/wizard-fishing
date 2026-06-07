extends AnimatedSprite2D
class_name AnimationComponent

var body : CharacterBody2D

func initialize(pbody):
	body = pbody

func reset_flip():
	flip_h = false
	offset.x = 0

func flip() -> void:
	if body:
		if body.velocity.x > 0:
			flip_h = false
		elif body.velocity.x < 0:
			flip_h = true

func attached_flip(attached_body, AP):
	if body:
		if AP.position.x > 0: 
			if attached_body.get_real_velocity().x  > 0:
				print("1")
				flip_h = false
				offset.x = 0
			elif attached_body.get_real_velocity().x < 0:
				print("2")
				flip_h = true
				offset.x = AP.position.x * 2
		elif AP.position.x < 0:
			if attached_body.get_real_velocity().x < 0:
				print("3")
				flip_h = true
				offset.x = 0
			elif attached_body.get_real_velocity().x >   0:
				print("4")
				flip_h = false
				offset.x = AP.position.x * 2
