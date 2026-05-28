@tool
class_name AttachmentComponent
extends Node2D

@export_group("Attachment Point Parameters")
@export var attach_point : Array [Vector2]

var body

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _gen_AP():
	for i in attach_point:
		var AP = Node2D.new()
		AP.position = i
		add_child(AP)

func _attach(body, AP):
	pass

func _draw() -> void:
	for i in attach_point:
		draw_circle(i, 1, Color(0.0, 0.0, 0.902, 1.0))
