extends State
class_name FishIdle

var movement : MovementComponent


func Enter(Parent : StateMachine):
	movement = Parent.movement_component
	Transitioned.emit(self, "FishWander")
