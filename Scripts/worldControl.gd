extends TextureFrame

#class variables
var shop_data = preload("res://Scenes/Shop.xml")
var world1_data = preload("res://Scenes/World.xml")
var world2_data = preload("res://Scenes/World2.xml")
var world3_data = preload("res://Scenes/World3.xml")

func _ready():
	# maybe load a paused game screen
	if GLOBALS.last_scene == "pause":
		GLOBALS.last_scene = ""
		GLOBALS.V()
	
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if (event.type == InputEvent.KEY):
		# IF 'Q' key released
		if (event.scancode == KEY_Q && event.pressed == false):
			# re init all vars
			ResourceLoader.load("res://Scripts/GLOBALS.gd")
			# goto main menu
			get_tree().change_scene("res://Scenes/Start.xml")
			
		# IF 'P' key pressed
		if (event.scancode == KEY_P && event.pressed == false):
			GLOBALS.last_scene = "game"
			#save current scene and go to pause menu
			GLOBALS.P("res://Scenes/Pause.xml")
			
# manages transitions
func _process(delta):
	# check if current world matches level
	
	# check level up
	if GLOBALS.enemy_counter <= 0 || GLOBALS.base_is_dead:
		GLOBALS.g_current_level += 1
		GLOBALS.base_is_dead = false
		
		# world 1
		if GLOBALS.g_current_level == 0:
			GLOBALS.enemy_counter = 4
			
		# shop
		elif GLOBALS.g_current_level == 1:
			GLOBALS.enemy_counter = 1 # dummy enemy
			get_node("World").queue_free()
			add_child(shop_data.instance())
			
		# world 2
		elif GLOBALS.g_current_level == 2:
			GLOBALS.enemy_counter = 12
			get_node("Shop").queue_free()
			add_child(world2_data.instance())

			
		# shop
		elif GLOBALS.g_current_level == 3:
			GLOBALS.enemy_counter = 1 
			get_node("World2").queue_free()
			add_child(shop_data.instance())
			
		# world 3
		elif GLOBALS.g_current_level == 4:
			GLOBALS.enemy_counter = 13
			get_node("Shop").queue_free()
			add_child(world3_data.instance())
			
		# victory
		elif GLOBALS.g_current_level == 5:
			GLOBALS.enemy_counter = 0
			get_tree().change_scene("res://Scenes/Victory.xml")