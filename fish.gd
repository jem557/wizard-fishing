extends RigidBody2D

@onready var hook = get_tree().get_first_node_in_group("hook")

@export var sprite : Sprite2D
@export var latch_point : Node2D
@export var hook_area : Area2D

@export var speed : float = 1000
@export var weight : float = 2

var wait_time
var latch_offset
var hooked : bool
var hookpoint
var moving : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hookpoint = hook.get_node("Hookpoint")
	gravity_scale = 0
	wait_time = randi_range(1, 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not hooked and not moving:
		move()
	if linear_velocity.x < 0:
		if not sprite.flip_h:
			latch_point.position = latch_point.position * -1
			hook_area.position = hook_area.position * -1
			sprite.flip_h = true
	elif linear_velocity.x > 0:
		if sprite.flip_h:
			latch_point.position = latch_point.position * -1
			hook_area.position = hook_area.position * -1
			sprite.flip_h = false
	if hooked:
		var world_offset = to_global(latch_offset) - global_position
		var move_dir = hookpoint.global_position - (global_position + world_offset)
		if move_dir.length() > 1.0:
			global_rotation = lerp_angle(global_rotation, move_dir.angle(), 5 * delta)
		global_position = hookpoint.global_position - to_global(latch_offset) + global_position

func _on_hook_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("hook"):
		hooked = true
		freeze = false
		latch_offset = to_local(latch_point.global_position)

func move():
	wait_time = randi_range(1, 4)
	moving = true
	var angle = deg_to_rad(randf_range(-30, 30))
	if randi() % 2 == 0:
		angle += PI
	var direction = Vector2(cos(angle), sin(angle))

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "linear_velocity", direction * speed, 0.5)
	await get_tree().create_timer(randf_range(1.0, 2.0)).timeout

	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "linear_velocity", Vector2.ZERO, 0.5)
	await get_tree().create_timer(wait_time).timeout
	moving = false
	
func move_away(wall_normal: Vector2) -> void:
	if hooked:
		moving = false
		return
	moving = true
	var base_angle = wall_normal.angle()
	var angle = base_angle + deg_to_rad(randf_range(-30, 30))
	await _swim(angle)
	moving = false

func _swim(angle : float):
	var direction = Vector2(cos(angle), sin(angle))
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "linear_velocity", direction * speed, 0.5)
	await get_tree().create_timer(randf_range(1.0, 2.0)).timeout
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "linear_velocity", Vector2.ZERO, 0.5)
	await get_tree().create_timer(wait_time).timeout

func _on_wall_detection_body_entered(body: Node2D) -> void:
	var away = (global_position - body.global_position).normalized()
	linear_velocity = Vector2.ZERO
	move_away(away)
