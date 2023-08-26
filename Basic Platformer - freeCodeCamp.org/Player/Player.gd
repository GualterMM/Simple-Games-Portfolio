extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal player_jumped
signal player_fell
signal player_idle
signal player_ran
signal player_hit
signal player_death

var health = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle jump and emit signals
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if velocity.y < 0:
		player_jumped.emit()
	elif velocity.y > 0:
		player_fell.emit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move (left)", "move (right)")
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			player_ran.emit()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			player_idle.emit()
			
	if direction < 0:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction > 0:
		get_node("AnimatedSprite2D").flip_h = false
		
	move_and_slide()
	
func take_damage(dmg):
	health -= dmg
	if health <= 0:
		queue_free()


func _on_player_idle():
	pass # Replace with function body.
