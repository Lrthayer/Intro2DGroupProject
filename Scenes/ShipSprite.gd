extends Sprite


#Starts when scene is loaded 
func _ready():
	set_process(true)
	
func _process(delta):
	pass
	
func _on_ColorPicker_color_changed( color ):
	self.set_modulate(color)