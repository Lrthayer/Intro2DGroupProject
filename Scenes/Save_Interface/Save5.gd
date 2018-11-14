extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var Save_Scene = load("res://Scenes/Save_Interface/Save3.tscn")


export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var directory = Directory.new()
	directory.open("user://Playlists/")
	
	directory.list_dir_begin(true,true)
	var file = directory.get_next()
	
	while (file != ""):
		dropdown.add_item(file)
		file = directory.get_next()
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/temp.tscn")


func _on_SaveButton_pressed():
	var obj1 = Save_Scene.instance()
	self.add_child(obj1)
	self.get_node("MyDialog").queue_free()
