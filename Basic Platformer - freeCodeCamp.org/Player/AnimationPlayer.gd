extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play("Idle")

func _on_player_player_idle():
	self.play("Idle")

func _on_player_player_ran():
	self.play("Run")

func _on_player_player_jumped():
	self.play("Jump")

func _on_player_player_fell():
	self.play("Fall")

