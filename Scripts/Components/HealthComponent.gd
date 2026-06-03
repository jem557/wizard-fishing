class_name HealthComponent
extends Node

var body

var max_hp : int
var hp : int
var _str : int
var dead : bool
var hp_ratio : float 

func _process(_delta: float) -> void:
	if hp <= 0 and not dead:
		dead = true

func initialize(pbody):
	body = pbody
	max_hp = body.stats.max_health
	hp = max_hp
	if body.stats is FishStats:
		_str = body.stats.strength
	
func damage(amount : int):
	hp = hp - amount
	update_str()

func heal(amount : int):
	hp = hp + amount
	update_str()
	
func revive(amount):
	hp = amount
	dead = false

func update_str():
	if body is Fish:
		hp_ratio = float(hp) / float(max_hp)
		_str = _str * sqrt(hp_ratio)
		print(hp_ratio)
	else: 
		return
