extends ColorPickerButton


func _on_ColorPicker_color_changed( color ):
	self.color = color

#when user presses button move the color picker to where they clicked
func _on_ColorPicker_pressed():
	if !self.get_parent().get_node("ColorPickerArea2D").visible:
		self.get_parent().get_node("ColorPickerArea2D").visible = true
	else:
		self.get_parent().get_node("ColorPickerArea2D").visible = false