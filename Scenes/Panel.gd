extends Panel

var followMouse = true

func _ready():
	set_process(true)
	
func _process(delta):
	if followMouse:
		self.rect_global_position = (Vector2(get_global_mouse_position().x - self.get_size().x/2, get_global_mouse_position().y - self.get_size().y/2))
		update()