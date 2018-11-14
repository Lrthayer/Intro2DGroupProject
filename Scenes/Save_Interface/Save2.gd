extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Save_Scene1 = load("res://Scenes/Save_Interface/Save.tscn")
var Save_Scene2 = load("res://Scenes/Save_Interface/Save3.tscn")
var Save_Scene3 = load("res://Scenes/Save_Interface/Save4.tscn")
var Save_Scene4 = load("res://Scenes/Save_Interface/Save5.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#save the level
func _on_SaveLevel_pressed():
	pass # replace with function body

#save as a playlist
func _on_SaveButton_pressed():
	var obj1 = Save_Scene3.instance()
	self.add_child(obj1)
	self.get_node("MyDialog").queue_free()


#delete the form
func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/temp.tscn")


func _on_SaveLevel2_pressed():
	var obj1 = Save_Scene2.instance()
	self.add_child(obj1)
	self.get_node("MyDialog").queue_free()


func _on_SaveButton2_pressed():
	var obj1 = Save_Scene4.instance()
	self.add_child(obj1)
	self.get_node("MyDialog").queue_free()
