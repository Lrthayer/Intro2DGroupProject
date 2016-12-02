
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	#change current scene to the previous scene
	print("Going back a scene...")
	
	#check last scene
	if (GLOBALS.last_scene == "game"):
		get_tree().change_scene("res://Scenes/WorldInterface.xml")
	if (GLOBALS.last_scene == "start"):
		get_tree().change_scene("res://Scenes/Start.xml")
	if (GLOBALS.last_scene == "pause"):
		get_tree().change_scene("res://Scenes/Pause.xml")
