extends Node

const MAX_RANGE = 150.0

@export var sword_ability: PackedScene

var damage = 5.0
var base_wait_time


# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time = $Timer.wait_time
	GameEvents.ability_upgrades_added.connect(on_ability_upgrade_added)


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if (player == null):
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")	
	
	enemies = enemies.filter(func(enemy: Node2D): 
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if (enemies.size() == 0):
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D): 
		var a_dist = a.global_position.distance_squared_to(player.global_position)
		var b_dist = b.global_position.distance_squared_to(player.global_position)
		
		return a_dist < b_dist
	)
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	if (foreground_layer == null):
		return
	
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_dir = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_dir.angle()
	
	
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if (upgrade.id != 'sword_rate'):
		return
		
	var percent_reduction = current_upgrades['sword_rate']['quantity'] * .1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	
	# Important: after setting a new wait_time, you need to start the Timer again
	$Timer.start()
