extends Button

func _ready():
	set_process_input(true)

#buy an upgrade for damage
func _pressed():
	if GLOBALS.next_level != "":
		#set the next_level to the new next level for the new current level
		GLOBALS.next_level = ""
		#TODO change scene to next in the list
		get_tree().change_scene("")
