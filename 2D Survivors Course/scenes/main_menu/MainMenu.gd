extends MarginContainer

@onready var play_button = %PlayButton
@onready var quit_button = %QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(on_play_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)


func on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
func on_quit_button_pressed():
	get_tree().quit()
