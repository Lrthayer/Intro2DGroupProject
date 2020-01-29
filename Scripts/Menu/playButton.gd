extends Button

func _ready():
	set_process_input(true)

#when pressed, user gets to pick which playlist to play
func _pressed():
	GLOBALS.last_scene = "start"
	get_tree().change_scene("res://Scenes/Load_Interface/LoadPlaylist.tscn")
	GLOBALS.reset()
	#todo open playlist options
