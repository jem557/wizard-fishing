class_name FishStats
extends Resource

@export_enum("Common", "Uncommon", "Rare", "Mythical", "Legendary") var rarity : String = "Common"

@export var health : int = 100
@export var stamina : int = 100
@export var weight : float = 3.2

@export_group("General Stats")
@export var strength : int
@export var agility : int
@export var intelligence : int

@export_group("If Magic")
@export var is_magic : bool = false 
@export var mana : int = 0
