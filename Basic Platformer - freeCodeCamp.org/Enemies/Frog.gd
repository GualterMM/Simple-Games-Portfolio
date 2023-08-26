extends CharacterBody2D

const SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimatedSprite2D")
var chase = false
var player

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	
	# Chase only if player is within the player detection circle
	if chase == true:
		
		if anim.animation != "Death":
			# Play the jumping animation
			anim.play("Jump")
		
		# Get player data
		player = get_node("../../Player/Player")
		
		# Get player direction as a normalized vector
		var direction = (player.position - self.position).normalized()
		
		# Flip sprite towards the player
		if direction.x > 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
		
		# Move towards the player
		velocity.x = direction.x * SPEED
	
	else:
		if anim.animation != "Death":
			anim.play("Idle")
			
		velocity.x = 0
			
	
	move_and_slide()
	

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_hurtbox_body_entered(body):
		if body.name == "Player":
			death()

func _on_hitbox_body_entered(body):
	if body.name == "Player":
		body.take_damage(3)
		death()
		
func death():
	Game.gold += 5
	Utils.saveGame()
	
	chase = false
	anim.play("Death")
	await anim.animation_finished
	self.queue_free()



