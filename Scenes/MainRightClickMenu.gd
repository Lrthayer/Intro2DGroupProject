extends PopupMenu

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.add_item("add image to scene")
	self.connect("index_pressed", self, "loadImage")
	
func loadImage(index):
	print (self.items[index])
	#self.get_parent().get_node("FileDialog").rect_position = self.get_viewport().get_mouse_position()
	self.get_parent().get_node("Camera2D").get_node("FileDialog").popup()
	self.get_parent().get_node("Camera2D").get_node("FileDialog").rect_global_position = self.get_global_mouse_position()
	#self.visible = true
	#self.get_parent().get_node("FileDialog").visible = true
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
