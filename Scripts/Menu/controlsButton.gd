extends Button

func _ready():
	set_process_input(true)

func _pressed():
	#change current scene to "controls.xml"
	print(" >> going to controls >> ")
	
	if GLOBALS.last_scene == "game":
		GLOBALS.last_scene = "pause"
	if GLOBALS.last_scene == "initial":
		GLOBALS.last_scene = "start"
	
	#hide self then show control menu
	self.get_parent().hide()
	self.get_parent().get_parent().get_node("ControlsMenu").show()
