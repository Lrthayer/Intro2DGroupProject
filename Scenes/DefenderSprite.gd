extends Sprite

func _ready():
	pass

func _on_ColorPicker_color_changed( color ):
	self.set_modulate(color)