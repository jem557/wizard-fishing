extends CharacterBody2D
class_name hook

@export_group("Components")
@export var attachment_component : AttachmentComponent
@export var behavior_component : BehaviorComponent
@export var detection_component : DetectionComponent
@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var animation_component : AnimationComponent

var attached : bool = false

func _ready() -> void:
	EntityUtils.Initalize_Components(self)
