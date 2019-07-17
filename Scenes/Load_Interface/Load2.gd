extends Control

export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)

var levels = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	var label = get_node("MyDialog/Label2").get_text()
	get_node("MyDialog/Label2").set_text(label+GLOBALS.current_playlist_name)
	var directory = Directory.new()
	var directory2 = Directory.new()
	
	directory.open("user://Playlists/" + GLOBALS.current_playlist_name)
	
	directory.list_dir_begin(true,true)
	directory2.list_dir_begin(true,true)
	
	var file = directory.get_next()
	
	var id_num = 0
	var level = ""
	
	#load levels
	while (file != ""):
		
		print(file)
		directory2.open("user://Playlists/" + GLOBALS.current_playlist_name + "/" + file)
		level = directory2.get_next()
		print(level + "meow")
		dropdown.add_item(level,id_num)
		levels.append(file)
		id_num+=1
		file=directory.get_next()
	
	directory.list_dir_end ()
	directory2.list_dir_end()

func _on_LoadButton_pressed():

	#get directory value
	var selectedLevel = dropdown.get_selected_id()
	
	#set level
	GLOBALS.current_level_name = levels[selectedLevel]
	
	#load level
	get_tree().change_scene("user://Playlists/" + GLOBALS.current_playlist_name + "/" + GLOBALS.current_level_name)  


func _on_CancelButton_pressed():
	
	GLOBALS.current_playlist_name = GLOBALS.temp_playlist
	get_tree().change_scene("res://Scenes/temp.tscn")  
