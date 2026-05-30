@tool
class_name AttachmentComponent
extends Node2D

@export_group("Attachment Point Parameters")
@export var show_debug : bool
@export var debug_size : float = 1.0
@export var attach_points : Array[AttachPoint]

var body
var attached : bool = false
var active_AP : Node2D
var attached_AP : Node2D


func _ready() -> void:
	body = get_parent()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _gen_AP():
	for i in attach_points:
		var AP = Node2D.new()
		add_child(AP)
		AP.position = i.pos
		AP.name = i.name

func _attach(attach_body : Node2D, AreaName : String):
	if attach_body.is_in_group("hook"):
		var hook_attach = attach_body.get_node("HookPoint")
		var ap : Node2D
		for i in get_children():
			if i.name == AreaName.replace("area_", ""):
				ap = i
		if hook_attach is Node2D and ap is Node2D:
			attached_AP = hook_attach
			active_AP = ap
			attached = true
		

func _lock_position(AP : Node2D, H_AP : Node2D):
	var offset = H_AP.global_position - AP.global_position
	body.global_position += offset


func _draw() -> void:
	if show_debug and Engine.is_editor_hint():
		for i in attach_points:
			draw_circle(i.pos, debug_size, i.color)
