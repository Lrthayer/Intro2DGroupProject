extends Button

func _ready():
	set_process_input(true)
	
func _pressed():
	#quits game
	print("Quit!")
	get_tree().quit()