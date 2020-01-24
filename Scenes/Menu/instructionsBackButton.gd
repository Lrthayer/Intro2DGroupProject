extends Button

func _ready():
	set_process_input(true)

func _pressed():
	#change current scene to the previous scene
	print("Going back to " + GLOBALS.last_scene + "...")

	#goto last scene
	if (GLOBALS.last_scene == "start"):
		GLOBALS.last_scene == "initial"
		get_tree().change_scene("res://Scenes/Menu/Start.tscn")
	if (GLOBALS.last_scene == "pause"):
		GLOBALS.last_scene == "game"
		#TODO get_tree().change_scene("res://Scenes/Pause.xml")
