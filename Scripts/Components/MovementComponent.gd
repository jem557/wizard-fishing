class_name MovementComponent
extends Node

@export var speed : float = 100
@export var acceleration : float = 30
@export var deceleration : float = 10

@export_group("X_Rotation Settings")
@export var x_lerp_stiffness : float = 15.0
@export var x_lerp_dampening : float = 2.0
@export_range(0,360) var x_max_rotation_angle : float = 22

@export_group("Y_Rotation Settings")
@export var y_lerp_stiffness : float = 15.0
@export var y_lerp_dampening : float = 2.0
@export_range(0,360) var y_max_rotation_angle : float = 22

var body
var move_dir = Vector2.ZERO
var rotation_angle_rad : float
var angular_velocity : float = 0.0
var rotation_offset = 0

func initialize(pbody):
	body = pbody

func move(delta)->void:
	if body == null:
		return
	if move_dir != Vector2.ZERO:
		body.velocity = body.velocity.move_toward(move_dir * speed, acceleration * delta)
	else:
		body.velocity = body.velocity.move_toward(move_dir * speed, deceleration * delta)
	body.move_and_slide()

func _rotateX(delta, tracked_body) -> void:
	if body:
		rotation_angle_rad = deg_to_rad(x_max_rotation_angle)
		var target_rotation = rotation_offset + clampf(tracked_body.velocity.x / speed, -1, 1) * rotation_angle_rad
		var error = target_rotation - body.rotation
		angular_velocity = lerpf(angular_velocity, error * x_lerp_stiffness, x_lerp_dampening * delta)
		body.rotation += angular_velocity * delta
	
func _rotateY(delta) -> void:
	if body:
		rotation_angle_rad = deg_to_rad(y_max_rotation_angle)
		var direction = signf(body.velocity.x)
		var target_rotation = rotation_offset + clampf(body.velocity.y / speed, -1, 1) * rotation_angle_rad * direction
		var error = target_rotation - body.rotation
		angular_velocity = lerpf(angular_velocity, error * y_lerp_stiffness, y_lerp_dampening * delta)
		body.rotation += angular_velocity * delta
	
