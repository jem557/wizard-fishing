class_name InputComponent 
extends Node

var move_dir : Vector2 = Vector2.ZERO
var body 

func initialize(pbody):
	body = pbody

func update() -> void: 
	move_dir = Input.get_vector("left","right","reel","lower")
