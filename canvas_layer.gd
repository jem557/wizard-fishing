extends CanvasLayer

@export var hook : RigidBody2D
@export var line_label : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_label = get_node("PanelContainer/LineLabel")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hook != null:
		line_label.text = "Line Length: " +  str(int(hook.line_length)) + "Ft"
