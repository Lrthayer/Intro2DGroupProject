extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"



func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/temp.tscn")


func _on_SaveButton_pressed():
	
	var directory = Directory.new()
	
	
	var level = self.get_node("./MyDialog/OptionButton").get_selected_id()
	GLOBALS.current_level_name = get_node("MyDialog/LineEdit").text
	
	if GLOBALS.current_level_name == "":
		self.get_node("./AcceptDialog").popup()
	elif directory.dir_exists("user://Playlists/" + GLOBALS.current_playlist_name + "/" + str(level) + "/"):
		self.get_node("./ConfirmationDialog").popup()
	else:
		directory.open("user://Playlists/" + GLOBALS.current_playlist_name + "/")
		directory.make_dir(str(level))
		GLOBALS.g_current_level = level
		GLOBALS.isSaving = true
		get_tree().change_scene("res://Scenes/temp.tscn")
		



func _on_ConfirmationDialog_confirmed():
	
	var level = self.get_node("./MyDialog/OptionButton").get_selected_id()
	
	#make a directory object
	var directory = Directory.new()
	
	#go to level directory
	directory.open("user://Playlists/" + GLOBALS.current_playlist_name + "/" + str(level))
	
	#start going down the list of files
	directory.list_dir_begin(true,true)
	
	#remove the two files
	var file_name = directory.get_next()
	directory.remove(file_name)
	file_name = directory.get_next()
	directory.remove(file_name)
	
	#end the list
	directory.list_dir_end()
	
	GLOBALS.g_current_level = level
	GLOBALS.isSaving = true
	
	
	get_tree().change_scene("res://Scenes/temp.tscn")
