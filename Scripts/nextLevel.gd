
extends Button

func _ready():
	set_process_input(true)
	

func _pressed():
	# decrement dummy variable to indicate
	#  that player is resuming the game
	GLOBALS.enemy_counter -= 1