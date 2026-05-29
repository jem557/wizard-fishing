@tool
class_name DetectionComponent
extends Node2D

@export var has_rays : bool
@export var has_hook_area : bool
@export var hook_area_size : float = 3 : set = _set_hook_area_size

@export_group("Ray Sizes")
@export var ray_length_up : float = 15 : set = _set_ray_up
@export var ray_length_down : float = 15 : set = _set_ray_down
@export var ray_length_left : float = 20 : set = _set_ray_left
@export var ray_length_right : float = 20 : set = _set_ray_right

var AP : Array
var areas : Array
var rays : Array

func _ready() -> void:
	if Engine.is_editor_hint():
		initialize()

func initialize():
	if has_rays:
		_rebuild_rays()
	if has_hook_area:
		_rebuild_Hook_areas(AP)	

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
			rays.clear()
	_add_ray(Vector2.RIGHT, ray_length_right, "ray_right")
	_add_ray(Vector2.LEFT, ray_length_left, "ray_left")
	_add_ray(Vector2.UP, ray_length_up, "ray_up")
	_add_ray(Vector2.DOWN, ray_length_down, "ray_down")

func _add_ray(direction: Vector2, length: float, ray_name : String) -> void:
	var ray := RayCast2D.new()
	ray.target_position = direction * length
	ray.name = ray_name
	add_child(ray)
	rays.append(ray)

#endregion

#region Hook Area Functions

func _set_hook_area_size(val : float) -> void:
	hook_area_size = val
	if Engine.is_editor_hint():
		_rebuild_Hook_areas(AP)

func _create_hook_shape() -> CircleShape2D:
	var circle = CircleShape2D.new()
	circle.radius = hook_area_size
	return circle

func _rebuild_Hook_areas(Attach_point : Array):
	for child in get_children():
		if child is Area2D and child.is_in_group("hook_area"):
			child.queue_free()
			areas.clear()
	for i in Attach_point:
		_add_hook_area(i.position, "area_" + i.name)

func _add_hook_area(location : Vector2, area_name : String):
	var area := Area2D.new()
	var collisionshape := CollisionShape2D.new()
	var circle = _create_hook_shape()
	add_child(area)
	areas.append(area)
	area.name = area_name
	area.position = location
	collisionshape.shape = circle
	area.add_child(collisionshape)
	area.add_to_group("hook_area")

func _toggle_hook_area(area_name : String, enable: bool):
	if areas:
		for i : Area2D in areas:
			if i.name == area_name:
				i.monitoring = enable
				var col : CollisionShape2D = i.get_child(0)
				if i.monitoring:
					col.debug_color = Color(0.002, 8.753, 11.287, 0.533)
				else:
					col.debug_color = Color(15.089, 0.0, 0.0, 0.38)

#endregion
