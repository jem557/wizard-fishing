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
@export var stamina_component : StaminaComponent

signal facing_changed(dir : int)

var facing : int = 1 :
	set(value):
		if value == 0 or value == facing:
			return
		facing = value
		facing_changed.emit(facing)
var attached : bool = false

func _ready() -> void:
	EntityUtils.Initalize_Components(self)

func caught() -> void:
	attachment_component._detach()
	queue_free()

func update_facing_from_velocity(vel : Vector2) -> void:
	if vel.x != 0:
		facing = signi(int(vel.x))
