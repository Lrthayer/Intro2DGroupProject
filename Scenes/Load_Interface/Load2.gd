extends Control

export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)

var levels = []
var num = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	var label = get_node("MyDialog/Label2").get_text()
	get_node("MyDialog/Label2").set_text(label+GLOBALS.current_playlist_name)
	var directory = Directory.new()
	var directory2 = Directory.new()
	
	directory.open("user://Playlists/" + GLOBALS.current_playlist_name)
	
	directory.list_dir_begin(true,true)
	
	
	var levelNum = directory.get_next()
	
	var id_num = 0
	var levelName = ""
	var level = ""
	var index = 0
	
	#load levels
	while (levelNum != ""):
		
		num.append(levelNum)
		directory2.open("user://Playlists/" + GLOBALS.current_playlist_name + "/" + levelNum)
		directory2.list_dir_begin(true,true)
		directory2.get_next()
		levelName = directory2.get_next()
		index = levelName.find(".tscn")
		levels.append(levelName.substr(0,index))
		level = "Level " + levelNum + ": " + levelName.substr(0,index);
		dropdown.add_item(level,id_num)
		id_num+=1
		levelNum=directory.get_next()
	
	directory.list_dir_end ()
	directory2.list_dir_end()

func _on_LoadButton_pressed():

	#get directory value
	var selectedLevel = dropdown.get_selected_id()
	
	#set level
	GLOBALS.current_level_name = levels[selectedLevel]
	
	GLOBALS.g_current_level = num[selectedLevel]
	
	GLOBALS.isLoading = true
	
	#load level in editor
	get_tree().change_scene("res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".tscn")  


func _on_CancelButton_pressed():
	GLOBALS.current_playlist_name = GLOBALS.temp_playlist
	GLOBALS.PressedCancelButton = true
	get_tree().change_scene("res://Scenes/temp.tscn")  
