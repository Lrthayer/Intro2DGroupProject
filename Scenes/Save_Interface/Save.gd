extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var isParent = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func cancel():
	if isParent:
		self.queue_free()
	else:
		self.get_parent().queue_free()
	
func _on_CancelButton_pressed():
	cancel()



func _on_SaveButton_pressed():
	GLOBALS.current_playlist_name = get_node("MyDialog/LineEdit").text
	#GLOBALS.current_level_name = "Level1"
	var directory = Directory.new()
	
	print(GLOBALS.current_playlist_name)
	
	if GLOBALS.current_playlist_name == "":
		get_node("AcceptDialog").popup()
	elif directory.dir_exists("user://Playlists/" + GLOBALS.current_playlist_name + "/"):
		get_node("AcceptDialog").popup()
	else:
		directory.open("user://Playlists/")
		directory.make_dir(GLOBALS.current_playlist_name)
		cancel()
