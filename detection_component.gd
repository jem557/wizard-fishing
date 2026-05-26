@tool
class_name DetectionComponent
extends Node2D

@export var has_rays : bool
@export var has_hook_area : bool



@export_group("Ray Sizes")
@export var ray_length_up : float = 15 : set = _set_ray_up
@export var ray_length_down : float = 15 : set = _set_ray_down
@export var ray_length_left : float = 20 : set = _set_ray_left
@export var ray_length_right : float = 20 : set = _set_ray_right

@export_group("Hook Variables")
@export var hook_area_size : float = 3 : set = _set_hook_area_size
@export var mouthright : Node2D
@export var mouthleft : Node2D

func _ready() -> void:
	if has_rays:
		_rebuild_rays()
	if has_hook_area and mouthright and mouthleft:
		_rebuild_Hook_areas(mouthright.position, mouthleft.position)
		

#region Ray Functions

#in editor functions
func _set_ray_up(val :float) -> void:
	ray_length_up = val
	if Engine.is_editor_hint(): 
		_rebuild_rays()
func _set_ray_down(val :float) -> void:
	ray_length_down = val
	if Engine.is_editor_hint(): 
		_rebuild_rays()
func _set_ray_left(val :float) -> void:
	ray_length_left = val
	if Engine.is_editor_hint(): 
		_rebuild_rays()
func _set_ray_right(val :float) -> void:
	ray_length_right = val
	if Engine.is_editor_hint(): 
		_rebuild_rays()

func _rebuild_rays() -> void:
	for child in get_children():
		if child is RayCast2D:
			child.queue_free()
	_add_ray(Vector2.RIGHT, ray_length_right)
	_add_ray(Vector2.LEFT, ray_length_left)
	_add_ray(Vector2.UP, ray_length_up)
	_add_ray(Vector2.DOWN, ray_length_down)

func _add_ray(direction: Vector2, length: float) -> void:
	var ray := RayCast2D.new()
	ray.target_position = direction * length
	add_child(ray)

#endregion

#region Hook Area Functions

func _set_hook_area_size(val : float) -> void:
	hook_area_size = val
	if Engine.is_editor_hint():
		_rebuild_Hook_areas(mouthright.position, mouthleft.position)

func _create_hook_shape() -> CircleShape2D:
	var circle = CircleShape2D.new()
	circle.radius = hook_area_size
	return circle

func _rebuild_Hook_areas(right : Vector2, left : Vector2):
	for child in get_children():
		if child is Area2D and child.is_in_group("hook_area"):
			child.queue_free()
	_add_hook_area(right)
	_add_hook_area(left)

func _add_hook_area(location : Vector2):
	var area := Area2D.new()
	var collisionshape := CollisionShape2D.new()
	var circle = _create_hook_shape()
	area.position = location
	collisionshape.shape = circle
	add_child(area)
	area.add_child(collisionshape)
	area.add_to_group("hook_area")

#endregion
