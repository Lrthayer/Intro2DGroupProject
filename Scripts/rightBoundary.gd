extends Sprite

func _process(_delta):
	if get_parent().clicked:
		self.global_position = get_global_mouse_position()
