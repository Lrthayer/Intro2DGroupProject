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


func _on_CancelButton_pressed():
	if isParent:
		self.queue_free()
	else:
		self.get_parent().queue_free()


func _on_SaveButton_pressed():
	
	var directory = Directory.new()
	
	
	var level = self.get_node("./MyDialog/OptionButton").get_selected_id()
	
	if directory.dir_exists("user://Playlists/" + GLOBALS.current_playlist_name + "/" + str(level) + "/"):
		pass
	else:
		directory.open("user://Playlists/" + GLOBALS.current_playlist_name)
		directory.make_dir(level)
		
