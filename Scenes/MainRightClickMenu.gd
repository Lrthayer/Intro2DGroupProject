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
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
