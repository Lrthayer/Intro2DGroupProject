extends Sprite

func _ready():
	set_process(true)
	
func _process(delta):
	if get_parent().clicked:
		self.global_position = get_global_mouse_position()