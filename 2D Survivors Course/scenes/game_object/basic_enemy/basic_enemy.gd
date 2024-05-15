extends CharacterBody2D

const MAX_SPEED = 40.0
const CLOSE_DIS = 10.0

@onready var health_component: HealthComponent = $HealthComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	var player_dis = global_position.distance_to(player_node.global_position)
	if (player_node != null and player_dis > CLOSE_DIS):
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
