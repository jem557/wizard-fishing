## Base fish class.
class_name StandardFish
extends CharacterBody2D

@export var movement_component : MovementComponent
@export var behavior_component : BehaviorComponent
@export var detection_component : DetectionComponent

func _Hooked(body):
	movement_component.hooked = true
	behavior_component.hooked = true

func _released():
	movement_component.hooked = false
	behavior_component.hooked = false
