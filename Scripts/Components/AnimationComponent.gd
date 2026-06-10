extends AnimatedSprite2D
class_name AnimationComponent

var body : CharacterBody2D
@export var bars : Node2D

func _on_facing_changed(dir : int) -> void:
	flip_h = dir < 0
	
func initialize(pbody):
	body = pbody
