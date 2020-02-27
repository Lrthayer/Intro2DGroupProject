extends ColorPickerButton

func _process(_delta):
	self.get_picker().rect_global_position = self.rect_global_position + Vector2(350, -200)
	self.get_popup().rect_global_position = self.rect_global_position + Vector2(350, -200)
