@tool
class_name DetectionComponent
extends Node2D

@export var has_rays : bool
@export var has_hook_area : bool

@export_group("Mouth Variables & Debug")
@export var hook_area_size : float = 3 : set = _set_hook_area_size
@export_subgroup("Right")
@export var mouth_right_pos : Vector2
@export var right_debug_color : Color = Color(0.0, 0.716, 0.0, 1.0)
@export_subgroup("Left")
@export var mouth_left_pos : Vector2
@export var left_debug_color : Color = Color(0.76, 0.561, 0.906, 1.0)

@export_group("Ray Sizes")
@export var ray_length_up : float = 15 : set = _set_ray_up
@export var ray_length_down : float = 15 : set = _set_ray_down
@export var ray_length_left : float = 20 : set = _set_ray_left
@export var ray_length_right : float = 20 : set = _set_ray_right

func _process(_delta: float) -> void:
	queue_redraw()

func _ready() -> void:
	if has_rays:
		_rebuild_rays()
	if has_hook_area:
		_rebuild_Hook_areas(mouth_right_pos, mouth_left_pos)

func _draw()->void:
	if Engine.is_editor_hint():
		draw_circle(mouth_left_pos, .5, left_debug_color, true)
		draw_circle(mouth_right_pos, .5, right_debug_color, true)

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
	_add_ray(Vector2.RIGHT, ray_length_right, "ray_right")
	_add_ray(Vector2.LEFT, ray_length_left, "ray_left")
	_add_ray(Vector2.UP, ray_length_up, "ray_up")
	_add_ray(Vector2.DOWN, ray_length_down, "ray_down")

func _add_ray(direction: Vector2, length: float, ray_name : String) -> void:
	var ray := RayCast2D.new()
	ray.target_position = direction * length
	ray.name = ray_name
	add_child(ray)

#endregion

#region Hook Area Functions

func _set_hook_area_size(val : float) -> void:
	hook_area_size = val
	if Engine.is_editor_hint():
		_rebuild_Hook_areas(mouth_right_pos, mouth_left_pos)

func _create_hook_shape() -> CircleShape2D:
	var circle = CircleShape2D.new()
	circle.radius = hook_area_size
	return circle

func _rebuild_Hook_areas(right : Vector2, left : Vector2):
	for child in get_children():
		if child is Area2D and child.is_in_group("hook_area"):
			child.queue_free()
	_add_hook_area(right, "hook_right")
	_add_hook_area(left, "hook_left")

func _add_hook_area(location : Vector2, area_name : String):
	var area := Area2D.new()
	var collisionshape := CollisionShape2D.new()
	var circle = _create_hook_shape()
	area.name = area_name
	area.position = location
	collisionshape.shape = circle
	add_child(area)
	area.add_child(collisionshape)
	area.add_to_group("hook_area")

func _toggle_hook_area(area_name : String, enable: bool):
	var detectors = get_children()
	var areas : Array
	for detector in detectors:
		if detector is Area2D:
			areas.append(detector)
	for i : Area2D in areas:
		if i.name == area_name:
			i.monitoring = enable
			var col : CollisionShape2D = i.get_child(0)
			if i.monitoring:
				col.debug_color = Color(0.002, 8.753, 11.287, 0.533)
			else:
				col.debug_color = Color(15.089, 0.0, 0.0, 0.38)

#endregion
