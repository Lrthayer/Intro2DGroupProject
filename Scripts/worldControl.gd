
extends TextureFrame

func _ready():
	set_process_input(true)
	
func _input(event):
	if (event.type == InputEvent.KEY):
        GLOBALS.last_scene = "game"
        if (event.scancode == KEY_Q && event.pressed == false):
			# 'Q' key released
            get_tree().change_scene("res://Scenes/Start.xml")

        if (event.scancode == KEY_P && event.pressed == false):
			# 'P' key pressed
            get_tree().change_scene("res://Scenes/Pause.xml")