extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)
var dict = {}
var level_max

func refreshItems():
	var file = File.new()
	file.open("res://Playlists/PlaylistInfo.json", file.READ)
	dict = parse_json(file.get_line())
	level_max = dict[GLOBALS.current_playlist_name]["Max_Levels"]
	
	dropdown.clear()
	for i in range(level_max):
		dropdown.add_item("Level " + str(i+1), i+1)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	if GLOBALS.new_playest:
		for i in range(10):
			dropdown.add_item("Level " + str(i+1), i+1)
	else:
		refreshItems()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CancelButton_pressed():
	GLOBALS.PressedCancelButton = true
	GLOBALS.new_playest = false
	get_tree().change_scene("res://Scenes/temp.tscn")


func _on_SaveButton_pressed():
	
	var directory = Directory.new()
	
	#varibles
	var objects = {}
	
	var data
	

	
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
		
		
		var file = File.new()
		
		#set the playlist amount of levels
		if GLOBALS.new_playest:
			
			file.open("res://Playlists/PlaylistInfo.json", file.WRITE)
			objects["Max_Levels"] = 10
			objects["Level_Count"] = 1
			dict[GLOBALS.current_playlist_name] = objects
			GLOBALS.new_playest = false
			
		else:
			
			
			file.open("res://Playlists/PlaylistInfo.json", file.READ)
			dict = parse_json(file.get_line())
			file.close()
			
			var level_count = dict[GLOBALS.current_playlist_name]["Level_Count"]
			dict[GLOBALS.current_playlist_name]["Level_Count"] = level_count + 1
			file.close()
			file.open("res://Playlists/PlaylistInfo.json", file.WRITE)
	
	
		file.store_line(to_json(dict))
		file.close()
		
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


func _on_AddLevels_pressed():
	
	if not GLOBALS.new_playest:
		
		var file = File.new()
		file.open("res://Playlists/PlaylistInfo.json", file.READ)
		dict = parse_json(file.get_line())
		var level_count = dict[GLOBALS.current_playlist_name]["Level_Count"]
		level_max = dict[GLOBALS.current_playlist_name]["Max_Levels"]
		
		if level_count == level_max:
			#add 5 more levels
			level_max = level_max+5
			
			#need to change file status from read to write
			
			#close the file
			file.close()
			
			#change file to write-only
			file.open("res://Playlists/PlaylistInfo.json", file.WRITE)
			
			#change the max level 
			dict[GLOBALS.current_playlist_name]["Max_Levels"] = level_max
			
			
			file.store_line(to_json(dict))
			file.close()
			refreshItems()
		else:
			self.get_node("./AcceptDialog2").popup()
	else:
		self.get_node("./AcceptDialog2").popup()
	
