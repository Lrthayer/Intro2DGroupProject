
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	#change current scene to "mainScene.xml"
	print("Play Game!")
	
	if GLOBALS.last_scene == "game":
	    GLOBALS.last_scene = "pause"
	if GLOBALS.last_scene == "initial":
	    GLOBALS.last_scene = "start"
	
	#get_tree().change_scene("res://Scenes/WorldInterface.xml")
	get_tree().change_scene("res://Scenes/WorldInterface.xml")
