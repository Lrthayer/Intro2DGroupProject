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
	
	#make a directory object
	var directory = Directory.new()
	
	#go to level directory
	directory.open("user://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level))
	
	#start going down the list of files
	directory.list_dir_begin(true,true)
	
	#remove the two files
	var file_name = directory.get_next()
	directory.remove(file_name)
	file_name = directory.get_next()
	directory.remove(file_name)
	
	#end the list
	directory.list_dir_end()
	
	GLOBALS.isSaving = true
	
	
	get_tree().change_scene("res://Scenes/temp.tscn")

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

