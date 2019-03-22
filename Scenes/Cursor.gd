extends Sprite


var followMouse = true

func _ready():
	set_process(true)

func _process(delta):
	if followMouse:
		self.global_position = Vector2(get_global_mouse_position().x - self.get_scale().x/2, get_global_mouse_position().y - self.get_scale().y/2)
		self.z_index = 10

func _on_Hide_mouse_enter():
	self.visible = false

func _on_unHide_mouse_exit():
	self.visible = true