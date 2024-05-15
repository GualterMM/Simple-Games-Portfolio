extends Node

signal experience_vial_collected(number: float)
signal ability_upgrades_added(upgrade: AbilityUpgrade, currentUpgrades: Dictionary)


func emit_experience_vial_collected(number: float):
	experience_vial_collected.emit(number)
	

func emit_ability_upgrades_added(upgrade: AbilityUpgrade, currentUpgrades: Dictionary):
	ability_upgrades_added.emit(upgrade, currentUpgrades)
