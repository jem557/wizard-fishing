class_name MovementComponent
extends Node

@export var body : CharacterBody2D
@export var sprite : Sprite2D

@export var speed : float = 100
@export var acceleration : float = 30
@export var deceleration : float = 10
@export_range(0,360) var max_rotation_angle : float = 22

var move_dir = Vector2.ZERO
var rotation_angle_rad : float
var angular_velocity : float = 0.0
var hooked : bool = false

func move(delta)->void:
	if not hooked:
		if body == null:
			return
		if move_dir != Vector2.ZERO:
			body.velocity = body.velocity.move_toward(move_dir * speed, acceleration * delta)
		else:
			body.velocity = body.velocity.move_toward(move_dir * speed, deceleration * delta)
		body.move_and_slide()

func _rotateX(delta) -> void:
	rotation_angle_rad = deg_to_rad(max_rotation_angle)
	var target_rotation = clampf(body.velocity.x / speed, -1, 1) * rotation_angle_rad
	var error = target_rotation - body.rotation
	angular_velocity = lerpf(angular_velocity, error * 15.0, 2.0 * delta)
	body.rotation += angular_velocity * delta
	
func _rotateY(delta) -> void:
	if not hooked:
		rotation_angle_rad = deg_to_rad(max_rotation_angle)
		var direction = signf(body.velocity.x)
		var target_rotation = clampf(body.velocity.y / speed, -1, 1) * rotation_angle_rad * direction
		var error = target_rotation - body.rotation
		angular_velocity = lerpf(angular_velocity, error * 15.0, 2.0 * delta)
		body.rotation += angular_velocity * delta
	
func _flip(dtcomp : DetectionComponent) -> void:
	if not hooked:
		if body.velocity.x > 0:
			sprite.flip_h = false
			dtcomp._toggle_hook_area("hook_left", false)
			dtcomp._toggle_hook_area("hook_right", true)
		elif body.velocity.x < 0:
			sprite.flip_h = true
			dtcomp._toggle_hook_area("hook_left", true)
			dtcomp._toggle_hook_area("hook_right", false)
