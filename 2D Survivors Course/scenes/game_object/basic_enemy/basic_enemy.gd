extends CharacterBody2D

const MIN_SPEED = 40.0
const MAX_SPEED = 140.0
const CLOSE_DIS = 5.0

@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = get_direction_to_player()
	if (direction == null):
		return
	
	animated_sprite.play("default")
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 0:
		animated_sprite.flip_h = false
	
	velocity = direction * randi_range(MIN_SPEED, MAX_SPEED)
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if (player_node == null):
		return
	
	var player_dis = global_position.distance_to(player_node.global_position)
	if (player_node != null and player_dis > CLOSE_DIS):
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
