
extends Button

func _ready():
	set_process_input(true)
	


func _pressed():
	#change current scene to "mainScene.xml"
	print("Play Game!")
	get_tree().change_scene("res://Scenes/mainScene.xml")
	pass

