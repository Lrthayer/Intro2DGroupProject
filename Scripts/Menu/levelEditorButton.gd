extends Button

func _ready():
	set_process_input(true)

func _pressed():
		# resume game screen
	GLOBALS.last_scene = "start"
	get_tree().change_scene("res://Scenes/LevelEditor.tscn")
