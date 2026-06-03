extends CharacterBody2D
class_name Fish

@export var stats : FishStats

@export_group("Components")
@export var attachment_component : AttachmentComponent
@export var behavior_component : BehaviorComponent
@export var detection_component : DetectionComponent
@export var movement_component : MovementComponent
@export var animation_component : AnimationComponent
@export var health_component : HealthComponent

var attached : bool = false

func _ready() -> void:
	EntityUtils.Initalize_Components(self)

func caught() -> void:
	attachment_component._detach()
	queue_free()
