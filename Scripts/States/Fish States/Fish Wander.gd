extends State
class_name FishWander

var movement : MovementComponent
var detection : DetectionComponent
var behavior : BehaviorComponent
var body : CharacterBody2D

func Enter(Parent : StateMachine):
	movement = Parent.movement_component
	detection = Parent.detection_component
	behavior = Parent.behavior_component
	body = Parent.body

func Physics_Update(_delta: float):
	movement.move_dir = behavior.move_dir
	behavior._roam()
	movement._flip(detection)
	movement.move(_delta)
	movement._rotateY(_delta)
