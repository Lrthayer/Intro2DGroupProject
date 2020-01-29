extends Button

func _ready():
	set_process_input(true)

func _pressed():
	get_tree().change_scene("res://Scenes/Menu/Start.tscn")
	self.get_tree().paused = false
	GLOBALS.last_scene == "start"