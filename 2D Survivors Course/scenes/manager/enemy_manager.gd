extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if (player == null):
		return
	
	# Stores a random direction
	# It works by rotating a vector pointing to the right to an angle between 0º and 360º
	var random_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# Takes a position SPAWN_RADIUS pixels away from the player, in the direction of random_dir
	var spawn_position = player.global_position + (random_dir * SPAWN_RADIUS)
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	enemy.global_position = spawn_position
	get_parent().add_child(enemy)
	
	
