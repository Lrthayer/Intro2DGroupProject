extends Area2D


var hovering = false
var clicked = false
var locked = false
var toggled = 0
var lockToggle = 0
var menuToggle = 0

var pointValue = 10
var health = 3
var damage = 1
var fireRate = 1
var fireRateStatic = 1
var fireRateDelta = .001

func _ready():
	var connectErrors = 0
	connectErrors += connect("mouse_entered", get_node("/root/Main"), "_on_Area2D_mouse_enter")
	connectErrors += connect("mouse_exited", get_node("/root/Main"), "_on_Area2D_mouse_exit")
	if connectErrors != 0:
		print(connectErrors)
	set_process(true)

#called every frame
func _process(_delta):
	if hovering:
		#if locked let parent node know
		if locked:
			get_node("/root/Main").cursorState = "locked"
		if Input.is_action_pressed("middle_click"):
			if lockToggle < 1:
				if locked:
					locked = false
					#tell parent to set cursor state
					self.get_node("/root/Main").cursorState = "hovering"
				else:
					locked = true
					#tell parent to set cursor state
					self.get_node("/root/Main").cursorState = "locked"
				lockToggle += 1
		else:
			lockToggle = 0
	
	if (hovering || clicked) && !locked:
		if  Input.is_action_pressed("left_click"):
			if toggled < 1:
				if clicked:
					clicked = false
				else:
					clicked = true
				toggled += 1
		else:
			toggled = 0
				
		if clicked:
			self.global_position = self.get_global_mouse_position()
			#fixes spawning a new object while moving this object
			if !get_node("/root/Main").overButton:
				get_node("/root/Main").overButton = true
			
		if  Input.is_action_pressed("edit") && !locked:
			if menuToggle < 1:
				#if already open, close
				if self.get_node("TurrentMenu").visible:
					self.get_node("TurrentMenu").visible = false
					self.get_node("TurrentMenu").position = Vector2(30000,30000)
					#set root state to placing
					self.get_node("/root/Main").editorState = "placing"
					self.get_node("/root/Main/Camera2D/StatesArea/StatesHBox/PlacingButton")._on_PlacingButton_pressed()
				else:
					self.get_node("TurrentMenu").position = Vector2(50,-100)
					self.get_node("TurrentMenu").visible = true
					self.get_node("/root/Main").editorState = "editing"
					self.get_node("/root/Main/Camera2D/StatesArea/StatesHBox/EditingButton")._on_EditingButton_pressed()
				menuToggle += 1
		else:
			menuToggle = 0
		
		if  Input.is_action_pressed("right_click") && !locked:
			self.get_node("/root/Main").set_hovering(false)
			self.free()

func _on_ImageArea2D_mouse_entered():
	hovering = true

func _on_ImageArea2D_mouse_exited():
	hovering = false
