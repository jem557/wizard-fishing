extends RigidBody2D

@export var hookpoint: Node2D
@export var lateral_force: float = 200.0
@export var max_lateral_speed: float = 150.0
@export var max_sink_speed: float = 100.0
@export var reel_speed: float = 2.0
@export var slack_speed: float = 3.0
@export var max_line: float = 20.0
@export var min_line: float = 0.5
@export var pull_strength: float = 100.0
@export var units_to_px: float = 40.0

var line_length: float = 1.0

func _physics_process(delta: float) -> void:
	# --- Line management ---
	if Input.is_action_pressed("lower"):
		line_length = minf(line_length + slack_speed * delta, max_line)
	if Input.is_action_pressed("reel"):
		line_length = maxf(line_length - reel_speed * delta, min_line)

	var max_depth_px := line_length * units_to_px
	var depth := global_position.y - hookpoint.global_position.y

	# --- Gravity control ---
	if depth >= max_depth_px:
		global_position.y = hookpoint.global_position.y + max_depth_px
		linear_velocity.y = 0.0
		gravity_scale = 0.0
	elif Input.is_action_pressed("reel"):
		gravity_scale = 0.0
		apply_force(Vector2(0, -pull_strength))
	else:
		gravity_scale = 1.0

	linear_velocity.y = minf(linear_velocity.y, max_sink_speed)

	# --- Lateral movement ---
	var dir := 0.0
	if Input.is_action_pressed("left"):
		dir = -1.0
	elif Input.is_action_pressed("right"):
		dir = 1.0

	if absf(linear_velocity.x) < max_lateral_speed:
		apply_force(Vector2(lateral_force * dir, 0.0))

	# --- Tilt ---
	var target_rotation := (linear_velocity.x / max_lateral_speed) * 0.4
	angular_velocity = lerpf(angular_velocity, (target_rotation - rotation) * 10.0, 0.2)
