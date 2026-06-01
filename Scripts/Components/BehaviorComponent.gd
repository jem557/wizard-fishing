class_name BehaviorComponent
extends Node

var body
var move_dir : Vector2 = Vector2.ZERO
var moving : bool = false
var hooked : bool = false
var rays : Array
var areas : Array

func _roam() -> void:
	moving = body.velocity != Vector2.ZERO
	var avoid : Vector2 = Vector2.ZERO
	for ray : RayCast2D in rays:
		if ray.is_colliding():
			avoid += ray.get_collision_normal()
	if avoid != Vector2.ZERO:
		var spread := randf_range(-PI / 4, PI / 4)
		move_dir = avoid.normalized().rotated(spread)
	elif not moving:
		var angle = randf_range(0, TAU)
		move_dir = Vector2(cos(angle), sin(angle))

func _findpack()->void:
	pass
