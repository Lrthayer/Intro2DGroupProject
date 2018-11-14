extends Camera2D
#starts when loaded up in scene
func _ready():
	set_process(true)
	set_process_input(true)
	
#called every frame
func _process(delta):
	
	
	if Input.is_action_pressed("CameraUp"):
		move(0,-10)
	if Input.is_action_pressed("CameraDown"):
		move(0,10)
	if Input.is_action_pressed("CameraLeft"):
		move(-10,0)
	if Input.is_action_pressed("CameraRight"):
		move(10,0)
		
	#check if camera has moved passed scroll current limit
	if get_child(0).get_child(0).get_max() < global_position.x:
		get_child(0).get_child(0).set_max(global_position.x)
	if get_child(1).get_child(0).get_max() < global_position.y:
		get_child(1).get_child(0).set_max(global_position.y)
	if get_child(0).get_child(0).get_min() > global_position.x:
		get_child(0).get_child(0).set_min(global_position.x)
	if get_child(1).get_child(0).get_min() > global_position.y:
		get_child(1).get_child(0).set_min(global_position.y)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			setZoom(-.1)
		if event.button_index == BUTTON_WHEEL_DOWN:
			setZoom(.1)

func move(x, y):
	
	self.global_position = Vector2(self.global_position.x + x,self.global_position.y + y)
	#move cursors
	get_child(0).get_child(0).set_value(self.global_position.x + x)
	get_child(1).get_child(0).set_value(self.global_position.y + y)

func setZoom(scale):
	self.set_scale(Vector2(self.get_scale().x + scale, self.get_scale().y + scale))
	set_zoom(Vector2(self.get_zoom().x + scale, self.get_zoom().y + scale))

func _on_HScrollBar_value_changed( value ):
	pass#self.set_global_pos(Vector2(value,self.global_position.y))

func _on_VScrollBar_value_changed( value ):
	pass#self.set_global_pos(Vector2(self.global_position.x, value))
