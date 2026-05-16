extends RigidBody2D

@export var hookpoint : Node2D

@export var lateral_force: float = 200.0
@export var vertical_force: float = -300.0
@export var max_lateral_speed: float = 150.0
@export var sink_speed : float = 100 

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	var dir = 0.0
	if Input.is_action_pressed("left"):
		dir = -1.0
	if Input.is_action_pressed("right"):
		dir = 1.0
		
	if Input.is_action_pressed("reel"):
		apply_force(Vector2(0, vertical_force))
		
	if not Input.is_action_pressed("reel") and linear_velocity.y < 0:
		gravity_scale = 20.0
		
	if linear_velocity.y > 0:
			gravity_scale = 2.0
			
	# Limits the maximum velocity going down to sink_speed value. 
	if linear_velocity.y >= sink_speed:
		linear_velocity.y = sink_speed
		
	# Only apply force if under max lateral speed
	if abs(linear_velocity.x) < max_lateral_speed:
		apply_force(Vector2(lateral_force * dir, 0))

	# Tilt based on horizontal velocity, restore when not moving
	var target_rotation = (linear_velocity.x / max_lateral_speed) * 0.4  # radians
	var rotation_error = target_rotation - rotation
	angular_velocity = lerp(angular_velocity, rotation_error * 10.0, 0.2)
