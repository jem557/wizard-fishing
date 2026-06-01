extends State
class_name CameraFollow

var following : bool
var target
var body

func _ready() -> void:
	target = get_tree().get_first_node_in_group("hook")
	body = get_tree().get_first_node_in_group("camera")
	attachment.body = body
	following = true

func Physics_Update(_delta: float):
	if following:
		attachment._follow(target, _delta)
	else:
		Transitioned.emit(self, "CameraIdle")
