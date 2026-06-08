extends Node2D

@export var area : Area2D

var timer : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	position = get_global_mouse_position()
	var overlapping = area.get_overlapping_bodies()
	for i in overlapping:
		if i is Fish:
			if timer >= .5:
				i.health_component.damage(5)
				timer = 0
