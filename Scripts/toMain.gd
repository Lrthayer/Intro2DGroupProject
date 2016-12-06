
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	
	GLOBALS.last_scene = "initial"
	
	get_tree().change_scene("res://Scenes/Start.xml")

