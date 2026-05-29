@tool
class_name AttachmentComponent
extends Node2D

@export_group("Attachment Point Parameters")
@export var show_debug : bool
@export var debug_size : float = 1.0
@export var attach_points : Array[AttachPoint]

var body

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _gen_AP():
	for i in attach_points:
		var AP = Node2D.new()
		add_child(AP)
		AP.position = i.pos
		AP.name = i.name

func _attach(AP):
	pass

func _draw() -> void:
	if show_debug and Engine.is_editor_hint():
		for i in attach_points:
			draw_circle(i.pos, debug_size, i.color)
