extends RigidBody2D

@onready var hook = get_tree().get_first_node_in_group("hook")

@export var sprite : Sprite2D
@export var latch_point : Node2D

@export var speed : float = 40
@export var weight : float = 2

var latch_offset
var hooked : bool
var hookpoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hookpoint = hook.get_node("Hookpoint")
	gravity_scale = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.x < 0:
		sprite.flip_h = true
	elif linear_velocity.x > 0:
		sprite.flip_h = false
	if hooked:
		var rotated_offset = latch_offset.rotated(global_rotation)
		var move_dir = hookpoint.global_position - (global_position + rotated_offset)
		if move_dir.length() > 1.0:
			global_rotation = lerp_angle(global_rotation, move_dir.angle(), 5 * delta)
			rotated_offset = latch_offset.rotated(global_rotation)  # recalculate after rotation update
		global_position = hookpoint.global_position - rotated_offset

func _on_hook_area_body_entered(body: Node2D) -> void:
	hooked = true
	freeze = true
	latch_offset = latch_point.global_position - global_position
