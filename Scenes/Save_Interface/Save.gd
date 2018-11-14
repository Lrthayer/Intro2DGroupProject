extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Save_Scene = load("res://Scenes/Save_Interface/Save5.tscn")
var Save_Scene2 = load("res://Scenes/Save_Interface/Save3.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func cancel():
	get_tree().change_scene("res://Scenes/temp.tscn")
	
func _on_CancelButton_pressed():
	cancel()



func _on_SaveButton_pressed():
	var obj1 = Save_Scene.instance()
	self.add_child(obj1)
	obj1.isParent = false
	self.get_node("MyDialog").queue_free()



func _on_SaveButton2_pressed():
	GLOBALS.current_playlist_name = get_node("MyDialog/LineEdit").text
	#GLOBALS.current_level_name = "Level1"
	var directory = Directory.new()
	
	print(GLOBALS.current_playlist_name)
	
	if GLOBALS.current_playlist_name == "":
		get_node("AcceptDialog").popup()
	elif directory.dir_exists("user://Playlists/" + GLOBALS.current_playlist_name + "/"):
		get_node("AcceptDialog2").popup()
	else:
		directory.open("user://Playlists/")
		directory.make_dir(GLOBALS.current_playlist_name)
		
		var obj1 = Save_Scene2.instance()
		self.add_child(obj1)
		self.get_node("MyDialog").queue_free()
