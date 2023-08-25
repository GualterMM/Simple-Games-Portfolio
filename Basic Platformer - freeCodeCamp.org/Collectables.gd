extends Node2D

const MAX_COLLECTABLES = 15 # Max amount of cherries

var collectables = 0 # Cherries collected so far
var Cherry = preload("res://Collectables/Cherry.tscn") # Cherry scene

func _on_timer_timeout():
	
	# Spawn cherries up to MAX_COLLECTABLES. After that, remove the Timer node
	if collectables < MAX_COLLECTABLES:
		var rng = RandomNumberGenerator.new()
		var cherry_pos = Vector2(rng.randi_range(17, 2285), rng.randi_range(400, 462))		
		var cherry_obj = Cherry.instantiate()
		
		cherry_obj.position = cherry_pos
		add_child(cherry_obj)
		collectables += 1
	else:
		get_node("Timer").queue_free()
		
