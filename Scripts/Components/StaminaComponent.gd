class_name StaminaComponent
extends Node

@export var stamina_bar : ProgressBar

var body

var max_stamina : int
var stamina : float
var base_agil : int
var _agil : int
var stamina_ratio : float 
var wt : float
var stamina_regen : float

func initialize(pbody):
	body = pbody
	if body.stats:
		max_stamina = body.stats.max_stamina
		stamina = max_stamina
		base_agil = body.stats.agility
		_agil = base_agil
		stamina_regen = body.stats.s_regen
		wt = body.stats.weight
		
func rest(delta):
	if stamina < max_stamina:
		stamina += stamina_regen * delta
	else:
		return
		
func drain(delta):
	stamina -= stamina_regen * delta
