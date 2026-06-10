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

var mouth_area : Area2D
var mouth_canonical : Vector2

var rays : Array
var active
var body

var ray_parent
var area_parent

signal hook_area_entered(body: Node2D)

func initialize(pbody) -> void:
	body = pbody
	if has_rays:
		ray_parent = Node2D.new()
		ray_parent.name = 'Rays'
		add_child(ray_parent)
		_rebuild_rays()
	if has_hook_area:
		area_parent = Node2D.new()
		area_parent.name = 'Areas'
		add_child(area_parent)
		_build_mouth_area()

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
	ray.set_collision_mask_value(1, false)
	ray.set_collision_mask_value(3, true)
	ray.target_position = direction * length
	ray.name = ray_name
	add_child(ray)
	rays.append(ray)

#endregion

#region Hook Area Functions

func _set_hook_area_size(val : float) -> void:
	hook_area_size = val
	if mouth_area:
		mouth_area.get_child(0).shape.radius = val

func _create_hook_shape() -> CircleShape2D:
	var circle = CircleShape2D.new()
	circle.radius = hook_area_size
	return circle

func _build_mouth_area() -> void:
	mouth_area = Area2D.new()
	var col := CollisionShape2D.new()
	col.shape = _create_hook_shape()
	mouth_area.name = "mouth_area"
	mouth_area.position = Vector2(mouth_canonical.x * body.facing, mouth_canonical.y)
	mouth_area.add_child(col)
	mouth_area.body_entered.connect(_on_mouth_entered)
	mouth_area.add_to_group("hook_area")
	area_parent.add_child(mouth_area)

func _on_facing_changed(dir : int) -> void:
	if mouth_area:
		mouth_area.position.x = mouth_canonical.x * dir

func _on_mouth_entered(h_body : Node2D) -> void:
	hook_area_entered.emit(h_body)

func set_mouth_enabled(enable : bool) -> void:
	mouth_area.set_deferred("monitoring", false)
	var col : CollisionShape2D = mouth_area.get_child(0)
	col.debug_color = Color(0, 8.7, 11.2, 0.5) if enable else Color(15, 0, 0, 0.38)


func _on_hook_area_entered(h_body: Node2D, area_name: String) -> void:
	hook_area_entered.emit(h_body, area_name)

#endregion
