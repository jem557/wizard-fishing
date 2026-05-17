extends Node2D

@export var anchor: Node2D

@export_group("Rope Structure")
## Number of joints in the rope. Lower = chunkier/chain-like. Higher = smoother.
@export_range(2, 30) var segment_count: int = 6
## Base segment length. Overridden at runtime by distance — kept for reference.
@export_range(1.0, 100.0) var segment_length: float = 20.0
@export_group("Physics")
## Constraint solving passes per frame. Higher = stiffer rope, less stretching.
@export_range(1, 20) var iterations: int = 10
## Downward force applied to each rope point per frame.
@export_range(0.0, 2000.0) var gravity: float = 200.0
## Energy retained per frame. Lower = rope loses momentum faster and settles quicker.
@export_range(0.0, 1.0) var damping: float = 0.98

var line_point: Node2D
var points: PackedVector2Array
var prev_points: PackedVector2Array

@onready var line: Line2D = $Line2D

func _ready() -> void:
	line_point = get_tree().get_first_node_in_group("hook").get_node("LinePoint")
	points.resize(segment_count + 1)
	prev_points.resize(segment_count + 1)
	for i in range(segment_count + 1):
		var p = anchor.global_position + Vector2(0, i * segment_length)
		points[i] = p
		prev_points[i] = p

func _physics_process(delta: float) -> void:
	var total_dist = anchor.global_position.distance_to(line_point.global_position)
	var dynamic_segment_length = total_dist / segment_count

	points[0] = anchor.global_position
	points[segment_count] = line_point.global_position

	for i in range(1, segment_count):
		var vel = (points[i] - prev_points[i]) * damping
		prev_points[i] = points[i]
		points[i] += vel + Vector2(0, gravity * delta * delta)

	for _iter in range(iterations):
		points[0] = anchor.global_position
		points[segment_count] = line_point.global_position
		for i in range(segment_count):
			var a = points[i]
			var b = points[i + 1]
			var dist = a.distance_to(b)
			if dist == 0.0:
				continue
			var diff = (dist - dynamic_segment_length) / dist
			var offset = (b - a) * diff * 0.5

			if i != 0:
				points[i] += offset
			if i + 1 != segment_count:
				points[i + 1] -= offset

	# Convert global points to local for Line2D
	var local_points: PackedVector2Array
	local_points.resize(points.size())
	for i in range(points.size()):
		local_points[i] = to_local(points[i])
	line.points = local_points
