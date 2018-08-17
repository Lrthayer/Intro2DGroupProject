extends Area2D

var hovering = false
var clicked = false
var locked = false
var toggled = 0
var lockToggle = 0

var menuToggle = 0

func _ready():
	set_process(true)

#called every frame
func _process(delta):
	if hovering:
		#if locked let parent node know
		if locked:
			get_parent().cursorState = "locked"

		if Input.is_mouse_button_pressed(BUTTON_MIDDLE):
			if lockToggle < 1:
				if locked:
					locked = false
					#tell parent to set cursor state
					self.get_parent().cursorState = "hovering"
					print("unlocked")
				else:
					locked = true
					#tell parent to set cursor state
					self.get_parent().cursorState = "locked"
					print("locked")
				lockToggle += 1
		else:
			lockToggle = 0
	
	if (hovering || clicked) && !locked:
		if  Input.is_mouse_button_pressed(BUTTON_LEFT):
			if toggled < 1:
				if clicked:
					clicked = false
					print("false")
				else:
					clicked = true
					print("true")
				toggled += 1
		else:
			toggled = 0
				
		if  Input.is_action_pressed("edit") && !locked:
			if menuToggle < 1:
				#if already open, close
				if self.get_node("AttackerMenu").visible:
					self.get_node("AttackerMenu").visible = false
					#self.get_node("TurrentMenu/StatsVBox").set_hidden(true)
					#self.get_node("TurrentMenu/VisualVBox").set_hidden(true)
					self.get_node("AttackerMenu").position = Vector2(30000,30000)
					#set root state to placing
					self.get_node("/root/Main").editorState = "placing"
					self.get_node("/root/Main/Camera2D/StatesArea/StatesHBox/PlacingButton")._on_PlacingButton_pressed()
				else:
					self.get_node("AttackerMenu").position = Vector2(50,-100)
					self.get_node("AttackerMenu").visible = true
					#set root state to editing
					self.get_node("/root/Main").editorState = "editing"
					self.get_node("/root/Main/Camera2D/StatesArea/StatesHBox/EditingButton")._on_EditingButton_pressed()
				menuToggle += 1
		else:
			menuToggle = 0
				
				
		if clicked:
			self.global_position = get_global_mouse_position()
			#fixes spawning a new object while moving this object
			if !get_parent().overButton:
				get_parent().overButton = true

func _on_AttackerArea_mouse_enter():
	hovering = true

func _on_AttackerArea_mouse_exit():
	hovering = false