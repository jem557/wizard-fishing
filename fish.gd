extends CharacterBody2D

@onready var hookpoint = get_tree().get_first_node_in_group("hook").get_node("Hookpoint")
@export var sprite: Sprite2D
@export var latch_point: Node2D
@export var hook_area: Area2D
@export var speed: float = 50.0

var latch_offset: Vector2
var hooked: bool = false
var target_velocity: Vector2 = Vector2.ZERO
var wandering: bool = false

func _ready() -> void:
	_wander_loop()

func _physics_process(delta: float) -> void:
	if hooked:
		var move_dir = hookpoint.global_position - to_global(latch_offset)
		if move_dir.length() > 1.0:
			global_rotation = lerp_angle(global_rotation, move_dir.angle(), 5 * delta)
		global_position = hookpoint.global_position - to_global(latch_offset) + global_position
		return
	velocity = velocity.lerp(target_velocity, 5.0 * delta)
	if velocity.length() > 10.0:
		var angle = velocity.angle()
		var limit = deg_to_rad(30)
		var clamped_angle: float
		if abs(angle) > PI / 2:
			# Facing left — clamp around ±PI
			clamped_angle = sign(angle) * clamp(abs(angle), PI - limit, PI)
		else:
			# Facing right — clamp around 0
			clamped_angle = clamp(angle, -limit, limit)
		global_rotation = lerp_angle(global_rotation, clamped_angle, 5 * delta)
		sprite.flip_v = abs(angle) > PI / 2
	move_and_slide()

func _wander_loop() -> void:
	wandering = true
	while not hooked:
		if wandering:
			await _swim(deg_to_rad(randf_range(0, 360)), 30.0)
		else:
			await get_tree().process_frame

func _swim(base_angle: float, spread_deg: float) -> void:
	var angle = base_angle + deg_to_rad(randf_range(-spread_deg, spread_deg))
	target_velocity = Vector2(cos(angle), sin(angle)) * speed
	await get_tree().create_timer(randf_range(3.0, 6.0)).timeout
	target_velocity = Vector2.ZERO
	await get_tree().create_timer(randi_range(3, 7)).timeout

func _on_hook_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("hook"):
		hooked = true
		wandering = false
		latch_offset = to_local(latch_point.global_position)

func _on_wall_detection_body_entered(body: Node2D) -> void:
	if not body.is_in_group("wall") or hooked:
		return
	wandering = false
	velocity = Vector2.ZERO
	target_velocity = Vector2.ZERO

	# Determine which edge we're closest to and bounce off it
	var vp = get_viewport_rect()
	var pos = global_position
	var dist_left = pos.x - vp.position.x
	var dist_right = vp.position.x + vp.size.x - pos.x
	var dist_top = pos.y - vp.position.y
	var dist_bottom = vp.position.y + vp.size.y - pos.y

	var min_dist = min(dist_left, dist_right, dist_top, dist_bottom)
	var away_angle: float
	if min_dist == dist_left:
		away_angle = 0.0        # bounce right
	elif min_dist == dist_right:
		away_angle = PI         # bounce left
	elif min_dist == dist_top:
		away_angle = PI / 2     # bounce down
	else:
		away_angle = -PI / 2    # bounce up

	away_angle += deg_to_rad(randf_range(-20.0, 20.0))
	target_velocity = Vector2(cos(away_angle), sin(away_angle)) * speed
	await get_tree().create_timer(randf_range(1.5, 3.0)).timeout
	wandering = true
