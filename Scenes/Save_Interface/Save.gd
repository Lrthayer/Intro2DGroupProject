extends Control


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

func _on_SaveButton2_pressed():
	
	
	
	var tempName = get_node("MyDialog/LineEdit").text.to_lower()
	
	#GLOBALS.current_level_name = "Level1"
	var directory = Directory.new()
	
	if tempName == "":
		get_node("AcceptDialog").popup()
	elif directory.dir_exists("user://Playlists/" + tempName + "/"):
		get_node("AcceptDialog2").popup()
	else:
		GLOBALS.current_playlist_name = tempName
		
		directory.open("user://Playlists/")
		directory.make_dir(GLOBALS.current_playlist_name)
		
		get_tree().change_scene("res://Scenes/Save_Interface/Save3.tscn")
