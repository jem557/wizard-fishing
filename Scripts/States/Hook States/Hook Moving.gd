extends State
class_name HookMoving

func Physics_Update(delta: float):
	# Update Player Inputs
	input.update()
	
	#Sync Input Dir and Engage Movement Component
	movement.move_dir = input.move_dir
	movement.move(delta)
	movement._rotateX(delta, movement.body)
