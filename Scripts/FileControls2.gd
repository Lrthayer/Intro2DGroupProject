extends FileDialog

var turrent = preload("res://Scenes/TurretArea.tscn")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	popup()
	add_filter("*.json")

#User decided to hit save button or load button
func _on_FileDialog_confirmed():
	
	#put camera back to where it was
	get_parent().get_parent().get_node("Camera2D").set_global_pos(get_parent().get_parent().cameraCoordinates)
	
	#variables
	var dir = get_current_dir()
	var file = File.new()
	var data = {}
	file.open(dir + "/" + get_current_file(), file.READ)
	data.parse_json(file.get_line())
	file.close()
	
	print("hello")
	var object = turrent.instance()
	var x = float(data['turrent_pos_x'])
	var y = float(data['turrent_pos_y'])
	object.set_name("turret" + str(1))
	get_parent().get_parent().get_node("Objects").add_child(object)
	object.set_owner(self.get_parent())
	print(x)
	print(y)
	object.set_global_pos(Vector2(x,y))
	#allow movement from camera
	get_parent().get_parent().isDialogOn = false

#User decided to hit cancel on dialog box
func _on_FileDialog_popup_hide():
	
	#put camera back to where it was
	get_parent().get_parent().get_node("Camera2D").set_global_pos(get_parent().get_parent().cameraCoordinates)
	
	
	#------This makes user wait a second so user does not accidently add objects ------
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	#---------------------------------------------------------------------------------
	
	#allow movement from camera
	get_parent().get_parent().isDialogOn = false
	
	get_parent().queue_free()