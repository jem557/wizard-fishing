@tool
class_name AttachmentComponent
extends Node2D

@export_group("Attachment Point Parameters")
@export var show_debug : bool
@export var debug_size : float = 0.2
@export var attach_points : Array[AttachPoint]

var body
var attached_body
var attached : bool = false
var active_AP : Node2D
var attached_AP : Node2D
var attached_AC : AttachmentComponent

func initialize(pbody):
	body = pbody
	_gen_AP()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		queue_redraw()

func _gen_AP():
	for i in attach_points:
		var AP = Node2D.new()
		add_child(AP)
		AP.position = i.pos
		AP.name = i.name

func _attach(attach_body : Node2D) -> void:
	if not attach_body.is_in_group("hook") or attach_body.attached:
		return
	attached_body = attach_body
	for i in attach_body.get_children():
		if i is AttachmentComponent:
			attached_AC = i
	var hook_attach = attached_AC.get_node("hook")
	if hook_attach is Node2D:
		attached_AP = hook_attach
		active_AP = get_node("mouth")
		attach_body.attached = true
		body.attached = true
		body.detection_component.set_mouth_enabled(false)

func _detach():
	attached_body.attached = false
	
func _lock_position(ap : Node2D, target_ap : Node2D):
	var offset = target_ap.global_position - ap.global_position
	body.global_position += offset

func _follow(target, delta)-> void:
	if target:
		body.global_position.y = lerpf(body.global_position.y, target.global_position.y, 3.0 * delta)

func _on_facing_changed(dir : int) -> void:
	for i in attach_points.size():
		var ap : Node2D = get_child(i)
		ap.position.x = attach_points[i].pos.x * dir

func _draw() -> void:
	if show_debug and Engine.is_editor_hint():
		for i in attach_points:
			draw_circle(i.pos, debug_size, i.color)
