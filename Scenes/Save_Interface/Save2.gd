extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#save the level
func _on_SaveLevel_pressed():
	pass # replace with function body

#save as a playlist
func _on_SaveButton_pressed():
	get_tree().change_scene("res://Scenes/Save_Interface/Save4.tscn")


#delete the form
func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/temp.tscn")


func _on_SaveLevel2_pressed():
	get_tree().change_scene("res://Scenes/Save_Interface/Save3.tscn")


func _on_SaveButton2_pressed():
	get_tree().change_scene("res://Scenes/Save_Interface/Save5.tscn")

