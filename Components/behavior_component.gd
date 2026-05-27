class_name BehaviorComponent
extends Node

@export_range(0, 10) var fear : int = 5
@export var body : CharacterBody2D
@export var predator : bool

var move_dir : Vector2 = Vector2.ZERO
var moving : bool = false
var hooked : bool = false
var dtcomp_rays : Array

func _roam(detection_component: DetectionComponent) -> void:
	if dtcomp_rays.is_empty():
		for child in detection_component.get_children():
			if child is RayCast2D:
				dtcomp_rays.append(child)
	if not hooked:
		moving = body.velocity != Vector2.ZERO
		var avoid : Vector2 = Vector2.ZERO
		for ray : RayCast2D in dtcomp_rays:
			if ray.is_colliding():
				avoid += ray.get_collision_normal()
		if avoid != Vector2.ZERO:
			var spread := randf_range(-PI / 4, PI / 4)
			move_dir = avoid.normalized().rotated(spread)
		else:
			if not moving:
				var angle = randf_range(0, TAU)
				move_dir = Vector2(cos(angle), sin(angle))

func _findpack()->void:
	pass
