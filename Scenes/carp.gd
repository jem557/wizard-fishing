extends StandardFish

func _physics_process(delta: float) -> void:
	movement_component.move_dir = behavior_component.move_dir
	behavior_component._roam(detection_component)
	movement_component._rotateY(delta)
	movement_component._flip(detection_component)
	movement_component.move(delta)
