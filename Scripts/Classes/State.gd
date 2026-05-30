extends Node
class_name State

## Not all components may be used. Fill out as necessary.
@export_group("Set Components")
@export var movement : MovementComponent
@export var detection : DetectionComponent
@export var behavior : BehaviorComponent
@export var attachment : AttachmentComponent
@export var input : InputComponent

signal Transitioned

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
