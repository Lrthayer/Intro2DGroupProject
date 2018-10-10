extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Save_Scene1 = load("res://Save.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#save the level
func _on_SaveLevel_pressed():
	pass # replace with function body

#save as a playlist
func _on_SaveButton_pressed():
	var obj1 = Save_Scene1.instance()
	self.add_child(obj1)
	self.get_node("MyDialog").queue_free()


#delete the form
func _on_CancelButton_pressed():
	self.queue_free()
