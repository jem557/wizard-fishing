class_name MovementComponent
extends Node

@export var body : CharacterBody2D
@export var sprite : Sprite2D

@export var speed : float = 100
@export var acceleration : float = 30
@export var deceleration : float = 10
@export var max_rotation_angle : float = .4

var move_dir = Vector2.ZERO
var angular_velocity : float = 0.0

func tick(delta)->void:
	if body == null:
		return
	if move_dir != Vector2.ZERO:
		body.velocity = body.velocity.move_toward(move_dir * speed, acceleration * delta)
	else:
		body.velocity = body.velocity.move_toward(move_dir * speed, deceleration * delta)
	body.move_and_slide()

func _rotate(delta) -> void:
	var target_rotation = clampf(body.velocity.x / speed, -1, 1) * max_rotation_angle
	var error = target_rotation - body.rotation
	angular_velocity = lerpf(angular_velocity, error * 15.0, 2.0 * delta)
	body.rotation += angular_velocity * delta
	
func _flip(delta) -> void:
	if body.velocity.x > 0:
		sprite.flip_h = true
	elif body.velocity.x < 0:
		sprite.flip_h = false
