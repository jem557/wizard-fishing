extends CharacterBody2D
class_name Fish

@export var stats : FishStats
@export var sprite : Sprite2D

@export_group("Components")
@export var attachment_component : AttachmentComponent
@export var behavior_component : BehaviorComponent
@export var detection_component : DetectionComponent
@export var movement_component : MovementComponent

var attached : bool = false

func _ready() -> void:
	Initalize_Components()

func Initalize_Components() -> void:
	if movement_component:
		movement_component.body = self
		movement_component.sprite = sprite
	if behavior_component:
		behavior_component.rays = detection_component.rays
		behavior_component.areas = detection_component.areas
		behavior_component.body = self
	if attachment_component:
		attachment_component.body = self
		attachment_component._gen_AP()
		if detection_component:
			detection_component.AP = attachment_component.get_children()
	if detection_component:
		detection_component.initialize()

func caught() -> void:
	attachment_component._detach()
	queue_free()
