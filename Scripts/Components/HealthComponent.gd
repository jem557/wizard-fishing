class_name HealthComponent
extends Node

var body

var max_hp : int
var hp : int
var base_str : int
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
	if body.stats:
		base_str = body.stats.strength
		_str = base_str
	
func damage(amount : int):
	hp = hp - amount
	update_str(false)

func heal(amount : int):
	hp = hp + amount
	update_str(true)
	
func revive(amount):
	hp = amount
	dead = false

func update_str(restore : bool):
	if body is Fish:
			hp_ratio = float(hp) / float(max_hp)
			_str = base_str * sqrt(hp_ratio)
			print(_str, hp_ratio)
	else: 
		return

func calc_dif(target_str):
	var str_dif : int = _str - target_str
	if str_dif < 0:
		str_dif -= base_str
		str_dif = abs(str_dif)
	return str_dif
