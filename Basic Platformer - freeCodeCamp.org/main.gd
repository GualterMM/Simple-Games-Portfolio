extends Node2D

func _ready():
	Utils.loadGame()
	

func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	Game.playerHP = 10
	get_tree().change_scene_to_file("res://Levels/World 1/world.tscn")
