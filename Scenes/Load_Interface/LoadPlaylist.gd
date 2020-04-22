extends Control


export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)

var playlist = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var directory = Directory.new()
	directory.open("res://Playlists/")

	directory.list_dir_begin(true,true)
	var file = directory.get_next()

	var id_num = 0

	while (file != ""):

		if file == "PlaylistInfo.json":
			file = directory.get_next()
		else:
			
			dropdown.add_item(file,id_num)
			playlist.append(file)
			id_num+=1
			file = directory.get_next()


	directory.list_dir_end ( )

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Start.tscn")


func _on_LoadButton_pressed():
	GLOBALS.isPlaying = true
	GLOBALS.isLoading = true
	GLOBALS.changed_scene = true
	var id = dropdown.get_selected_id()
	GLOBALS.current_playlist_name = playlist[id]
	var directory = Directory.new()
	directory.open("res://Playlists/" + GLOBALS.current_playlist_name)
	var levelName = ""
	var index = 0
	
	directory.list_dir_begin(true,true)
	var file = directory.get_next()
	GLOBALS.g_current_level = file
	directory.list_dir_end ( )
	
	directory.open("res://Playlists/" + GLOBALS.current_playlist_name + "/" + file)
	
	directory.list_dir_begin(true,true)
	
	directory.get_next()
	levelName = directory.get_next()
	index = levelName.find(".tscn")
	GLOBALS.current_level_name = levelName.substr(0,index)
	
	#load level
	get_tree().change_scene("res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".tscn")  
