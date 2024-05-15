extends CanvasLayer

@export var upgrade_card_scene: PackedScene

@onready var card_container: HBoxContainer = %CardContainer


func _ready():
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate() 
		
		# VERY IMPORTANT: In order to use @onready variables from another Scene's script, they must be added to the current Scene
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		