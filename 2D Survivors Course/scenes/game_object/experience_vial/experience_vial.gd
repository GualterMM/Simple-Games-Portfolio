extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("default")

func _on_area_2d_area_entered(area):
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
