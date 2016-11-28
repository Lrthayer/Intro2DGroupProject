
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	#change current scene to "instructions.xml"
	print(" >> What To Play >> ")
	get_tree().change_scene("res://Scenes/Instructions.xml")
	pass


