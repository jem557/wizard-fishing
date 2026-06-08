class_name HealthComponent
extends Node

@export var health_bar : ProgressBar

var body

var max_hp : int
var hp : int
var base_str : int
var _str : int
var dead : bool
var hp_ratio : float 
var _fade_tween : Tween


func _process(_delta: float) -> void:
	if hp <= 0 and not dead:
		dead = true
	health_bar.value = hp

func initialize(pbody):
	health_bar.visible = false
	body = pbody
	max_hp = body.stats.max_health
	health_bar.max_value = max_hp
	hp = max_hp
	health_bar.value = hp
	if body.stats:
		base_str = body.stats.strength
		_str = base_str
	
func damage(amount : int):
	hp = hp - amount
	show_health_bar()
	update_str(false)

func heal(amount : int):
	hp = hp + amount
	show_health_bar()
	update_str(true)
	
func revive(amount):
	hp = amount
	show_health_bar()
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
	
func show_health_bar() -> void:
	if _fade_tween:
		_fade_tween.kill()
	health_bar.modulate.a = 1.0
	health_bar.visible = true
	_fade_tween = create_tween()
	_fade_tween.tween_property(health_bar, "modulate:a", 0.0, 2.5)
	_fade_tween.tween_callback(func(): health_bar.visible = false)
		
