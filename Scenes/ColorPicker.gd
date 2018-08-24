extends ColorPickerButton

func _ready():
	set_process(true)
	
func _process(delta):
	self.get_picker().rect_global_position = self.rect_global_position + Vector2(350, -200)
	self.get_popup().rect_global_position = self.rect_global_position + Vector2(350, -200)