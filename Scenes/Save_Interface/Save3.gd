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
		


func _on_AcceptDialog_confirmed():
	var directory = Directory.new()
	var level = self.get_node("./MyDialog/OptionButton").get_selected_id()
	GLOBALS.g_current_level = level
	directory.open("user://Playlists/" + GLOBALS.current_playlist_name + "/")
	directory.make_dir(str(level))
	GLOBALS.isSaving = true
	get_tree().change_scene("res://Scenes/temp.tscn")
