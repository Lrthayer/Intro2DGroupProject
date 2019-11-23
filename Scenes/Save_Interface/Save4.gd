extends Control


export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var directory = Directory.new()
	directory.open("user://Playlists/")

	directory.list_dir_begin(true,true)
	var file = directory.get_next()

	var id_num = 1

	while (file != ""):

		#user is saving it to different playlist
		if(file != GLOBALS.current_playlist_name):

			dropdown.add_item(file,id_num)
			id_num+=1
			file = directory.get_next()
		else:
			file = directory.get_next()

	directory.list_dir_end ( )

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CancelButton_pressed():
	GLOBALS.PressedCancelButton = true
	get_tree().change_scene("res://Scenes/temp.tscn")


func _on_SaveButton_pressed():
	var playlist_id = self.get_node("./MyDialog/dropdown").get_selected_id()
	var selected_playlist = self.get_node("./MyDialog/dropdown").get_item_text(playlist_id)
	GLOBALS.current_playlist_name = selected_playlist
	print(GLOBALS.current_playlist_name)
	get_tree().change_scene("res://Scenes/Save_Interface/Save3.tscn")
