extends hook
class_name StandardHook

func _ready() -> void:
	super._ready()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		var fish : Fish = get_tree().get_first_node_in_group("fish")
		fish.health_component.damage(10)
		print(fish.health_component.hp, " ", fish.health_component._str)
	if Input.is_action_just_pressed("heal"):
		var fish : Fish = get_tree().get_first_node_in_group("fish")
		fish.health_component.heal(10)
		print(fish.health_component.hp, " ", fish.health_component._str)
