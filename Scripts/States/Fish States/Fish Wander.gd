extends State
class_name FishWander

var movement : MovementComponent
var detection : DetectionComponent
var behavior : BehaviorComponent

func Enter(Parent : StateMachine):
	movement = Parent.movement_component
	detection = Parent.detection_component
	behavior = Parent.behavior_component

func Physics_Update(_delta: float):
	movement.move_dir = behavior.move_dir
	behavior._roam(detection)
	movement._flip(detection)
	movement.move(_delta)
	movement._rotateY(_delta)
