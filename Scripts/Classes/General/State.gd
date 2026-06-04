extends Node
class_name State

@export var c_body : CharacterBody2D

## Not all components may be used. Fill out as necessary.
@export_group("Set Components")
@export var animation : AnimationComponent
@export var attachment : AttachmentComponent
@export var behavior : BehaviorComponent
@export var detection : DetectionComponent
@export var health : HealthComponent
@export var input : InputComponent
@export var movement : MovementComponent
@export var stamina : StaminaComponent

signal Transitioned

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
