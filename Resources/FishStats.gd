class_name FishStats
extends Resource

@export_enum("Common", "Uncommon", "Rare", "Mythical", "Legendary") var rarity : String = "Common"

##Health has a direct relationship w/ strength. str = str * sqrt(current_hp / max_hp)
@export var max_health : int = 100
@export var max_stamina : int = 100
##Multiplier for stamina regeneration / second. 
@export var s_regen : int = 5
##Base Weight used to calculate sell price & strength multiplier.
@export var weight : float = 3.2
##Sell Price equation is sell_price = sell_price * weight * alive_value
@export var value : int = 1
##Multipler will be halved if the unit is dead when caught.
@export var living_multiplier : float = 1.2

@export_group("General Stats")
##Health has a direct relationship w/ strength. str = str * sqrt(current_hp / max_hp) as the fish is weakened 
@export var strength : int
##Agility is planned to determine how spastic the movements are. If a fish has high agility it will dart around. Likely directly related to weight, but not always.
@export var agility : int
##Indicates if a fish will see you as a threat or fall for bait.
@export var intelligence : int

@export_group("If Magic")
##Toggle for if a fish can cast spells or has other magical qualities.
@export var is_magic : bool = false 
@export var mana : int = 0
