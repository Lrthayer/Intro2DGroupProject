extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#save the level
func _on_SaveButton_pressed():
	
	
	var id = dropdown.get_selected_id()
	
	if id == 0:
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
		
		GLOBALS.isSaving = true
		#end the list
		directory.list_dir_end()
		
		get_tree().change_scene("res://Scenes/temp.tscn")
		
	elif id == 1:
		get_tree().change_scene("res://Scenes/Save_Interface/Save3.tscn")
	elif id == 2:
		get_tree().change_scene("res://Scenes/Save_Interface/Save.tscn")
	else:
		get_tree().change_scene("res://Scenes/Save_Interface/Save4.tscn")

	
	


func _on_CancelButton_pressed():
	GLOBALS.PressedCancelButton = true
	get_tree().change_scene("res://Scenes/temp.tscn")
