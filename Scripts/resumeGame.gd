
extends Button

func _ready():
	set_process_input(true)
	

func _pressed():
	#change current scene to "instructions.xml"
	GLOBALS.last_scene = "pause"
	print("Un-Pausing...")
	get_tree().change_scene("res://Scenes/WorldInterface.xml")


