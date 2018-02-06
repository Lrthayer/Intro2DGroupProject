
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	
	
	GLOBALS.reset()
	get_tree().change_scene("res://Scenes/LevelEditor.tscn")