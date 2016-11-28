
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	#change current scene to "controls.xml"
	print(" >> How To Play >> ")
	get_tree().change_scene("res://Scenes/Controls.xml")	
	pass

