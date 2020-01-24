extends Button

func _ready():
	set_process_input(true)

#when pressed, user gets to pick which playlist to play
func _pressed():
	GLOBALS.reset()
	#todo open playlist options
