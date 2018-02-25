extends FileDialog

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
	
	#allow movement from camera
	get_parent().get_parent().isDialogOn = false
	
	var savedict = {
	filename=get_current_file(),
	parent=get_parent().get_path()
	}
	
	#this is how i add more to the dictionary
	savedict["dir"] = get_current_dir()
	
	var dir = get_current_dir()
	var file = File.new()
	file.open(dir + "/" + get_current_file(), file.WRITE)
	file.store_string(savedict.to_json())
	file.close()
	

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