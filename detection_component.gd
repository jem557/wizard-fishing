@tool
class_name DetectionComponent
extends Node2D

var head
@export var ray_object : bool

#region Ray Export Variables
@export var ray_length_up : float = 15 : set = _set_ray_up
@export var ray_length_down : float = 15 : set = _set_ray_down
@export var ray_length_left : float = 20 : set = _set_ray_left
@export var ray_length_right : float = 20 : set = _set_ray_right
#endregion

#region Setters
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
#endregion

func _ready() -> void:
	_rebuild_rays()

func _rebuild_rays() -> void:
	for child in get_children():
		child.queue_free()
	_add_ray(Vector2.RIGHT, ray_length_right)
	_add_ray(Vector2.LEFT, ray_length_left)
	_add_ray(Vector2.UP, ray_length_up)
	_add_ray(Vector2.DOWN, ray_length_down)
	
func _add_ray(direction: Vector2, length: float) -> void:
	var ray := RayCast2D.new()
	ray.target_position = direction * length
	add_child(ray)
