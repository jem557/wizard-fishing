class_name BehaviorComponent
extends Node

var body
var move_dir : Vector2 = Vector2.ZERO
var moving : bool = false
var hooked : bool = false
var rays : Array
var areas : Array

func initialize(pbody):
	body = pbody
	
func _roam() -> void:
	if body:
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
			if hooked:
				move_dir.y = max(move_dir.y + 0.2, 0.0)
				move_dir = move_dir.normalized()


func _findpack()->void:
	pass
