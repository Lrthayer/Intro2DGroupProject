extends Button

func _ready():
	set_process_input(true)

func _pressed():
	GLOBALS.last_scene = "pause"
	#hide self then show instruction menu
	self.get_parent().hide()
	self.get_tree().paused = false
