extends Hook

func _physics_process(delta: float) -> void:
	
	# Update Player Inputs
	input_component.update()
	
	#Sync Input Dir and Engage Movement Component
	movement_component.move_dir = input_component.move_dir
	movement_component.tick(delta)
	movement_component._rotate(delta)
