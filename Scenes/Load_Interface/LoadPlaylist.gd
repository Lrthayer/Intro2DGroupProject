extends Control


export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)

var playlist = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var directory = Directory.new()
	directory.open("user://Playlists/")

	directory.list_dir_begin(true,true)
	var file = directory.get_next()

	var id_num = 0

	while (file != ""):

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
	print("meow")
