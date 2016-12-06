
extends TextureFrame

func _ready():
	set_process(true)
	
func _process(delta):
	get_node("Label").set_text("Score: " + str(GLOBALS.g_current_score))