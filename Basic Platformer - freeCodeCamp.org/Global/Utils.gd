extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	# Explicit declaration of a dictionary
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold": Game.gold,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	file.close()
	
func loadGame():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.gold = current_line["gold"]
		
		file.close()

func back_to_menu():
	get_tree().change_scene_to_file("res://main.tscn")
