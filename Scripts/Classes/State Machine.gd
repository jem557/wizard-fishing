extends Node
class_name StateMachine

@export var initial_state : State

@export_group("Object Parts")
@export var body : CharacterBody2D
@export var sprite : Sprite2D

@export_group("Components")
@export var detection_component : DetectionComponent
@export var movement_component : MovementComponent
@export var behavior_component : BehaviorComponent
@export var input_component : InputComponent
@export var attachment_component : AttachmentComponent

var current_state : State

var states : Dictionary = {}

func _ready() -> void:
	Initalize_Components()
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter(self)
		current_state = initial_state
			
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	print(state, new_state_name)
	if state != current_state:
		return
	
	var new_state : State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	
	new_state.Enter(self)
	
	current_state = new_state

func Initalize_Components() -> void:
	if body:
		if movement_component:
			movement_component.body = body
			movement_component.sprite = sprite
		if behavior_component:
			behavior_component.rays = detection_component.rays
			behavior_component.areas = detection_component.areas
			behavior_component.body = body
		if attachment_component:
			attachment_component.body = body
			if detection_component:
				attachment_component._gen_AP()
				detection_component.AP = attachment_component.get_children()
				detection_component.initialize()
