#var turrent = preload("res://Scenes/Turret.tscn")
var turrent
#var base = preload("res://Scenes/Base1.tscn")
var base
#var base2 = preload("res://Scenes/Base2.tscn")
var base2
var base3 
#var ground = preload("res://Scenes/Turret.tscn")
#var stun = preload("res://Scenes/MoverLevelEditor.tscn")
var stun
var attacker
var defender

#add a child
#get_parent().add_child(laserInstance)
var currentObject
var objectIndex = 0
var overButton = false
var pressed = false

var cursorColor = Color(0,0,0)
var cursorState = ""

var makeUnique = true

var editorState = "placing"

#Laser Object bool
var laserObjectPool = []
var laserObjectIndex = 0
var laserObjectPoolAmount = 50

#starts when loaded up in scene
func _ready():
	#tell global instance that we are in a level editor
	GLOBALS.g_current_level = "levelEditor"
	set_process(true)
		#create laserObject pool
	for i in range(laserObjectPoolAmount):
		laserObjectPool.append(self.get_node("/root/Node2D/TurretArea/TurrentMenu/ProjectileVBox/Laser").duplicate())
		#give the copy a name 
		laserObjectPool[-1].set_name("Laser" + str(i))
		
		#add a child
		self.add_child(laserObjectPool[-1])
		#laserObjectPool[-1].set_owner(self)
	
	turrent = self.get_node("TurretArea")
	stun = self.get_node("MoverArea")
	base = self.get_node("Base12D")
	base2 = self.get_node("Base22D")
	base3 = self.get_node("Base32D")
	attacker = self.get_node("AttackerArea")
	defender = self.get_node("DefenderArea")
	currentObject = "turrent"

#called every frame
func _process(delta):
	var mosLoc = get_global_mouse_pos()
	var posOffset = Vector2(mosLoc.x-20, mosLoc.y-20);
	#get_child(1).set_global_pos(posOffset)
	if  Input.is_action_pressed("left_click"):
		if !overButton && !pressed && editorState == "placing":
			var objectInstance = turrent.duplicate()
			objectInstance.set_hidden(false)
			objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
			objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			#we have to manually copy signals over
			if currentObject == "Base":
				objectInstance = base.duplicate()
				objectInstance.set_hidden(false)
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Base2":
				objectInstance = base2.duplicate()
				objectInstance.set_hidden(false)
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Base3":
				objectInstance = base3.duplicate()
				objectInstance.set_hidden(false)
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Mover":
				objectInstance = stun.duplicate()
				objectInstance.set_hidden(false)
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_child(0).get_child(1).connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_child(0).get_child(1).connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_child(0).get_child(2).connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_child(0).get_child(2).connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_node("MoverMenu/VisualVBox/HeightHBox/HeightSpinBox").connect("value_changed", objectInstance.get_node("/root/MoverArea/Mover"), "_on_height_value_changed")
				objectInstance.get_node("MoverMenu/VisualVBox/WidthHBox/WidthSpinBox").connect("value_changed", objectInstance.get_node("/root/MoverArea/Mover"), "_on_width_value_changed")
				objectInstance.get_node("MoverMenu/ColorPickerArea2D/ColorPicker").connect("color_changed", objectInstance.get_node("/root/MoverArea/Mover/KinematicBody2D/Sprite"), "_on_ColorPickerButton_color_changed")
				objectInstance.get_node("MoverMenu/ColorPickerArea2D").connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_node("MoverMenu/ColorPickerArea2D").connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Turrent":
				objectInstance = turrent.duplicate()
				objectInstance.set_hidden(false)
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_node("TurrentMenu").connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_node("TurrentMenu").connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_node("TurrentMenu").connect("mouse_enter", self.get_node("Cursor"), "_on_Hide_mouse_enter")
				objectInstance.get_node("TurrentMenu").connect("mouse_exit", self.get_node("Cursor"), "_on_unHide_mouse_exit")
				objectInstance.get_node("TurrentMenu/VisualVBox/HeightHBox/HeightSpinBox").connect("value_changed", objectInstance.get_node("TurrentMenu/VisualVBox/HeightHBox/HeightSpinBox").get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_height_value_changed")
				objectInstance.get_node("TurrentMenu/VisualVBox/WidthHBox/WidthSpinBox").connect("value_changed", objectInstance.get_node("TurrentMenu/VisualVBox/WidthHBox/WidthSpinBox").get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_width_value_changed")
				objectInstance.get_node("TurrentMenu/ColorPickerArea2D/ColorPicker").connect("color_changed", objectInstance.get_node("/root/TurrentArea/Turret/StaticBody2D/Sprite"), "_on_ColorPickerButton_color_changed")
				objectInstance.get_node("TurrentMenu/ColorPickerArea2D").connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_node("TurrentMenu/ColorPickerArea2D").connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Attacker":
				objectInstance = attacker
				objectInstance.set_hidden(false)
				makeUnique = false
			elif currentObject == "Defender":
				objectInstance = defender
				objectInstance.set_hidden(false)
				makeUnique = false
			
			objectInstance.set_global_pos(mosLoc)
			
			if makeUnique:
				#give the copy a name 
				objectInstance.set_name("object" + str(objectIndex))
				self.get_node("Objects").add_child(objectInstance)
				objectInstance.set_owner(self.get_parent())
				objectIndex += 1

			#since attacker and defender are the only ones who don't use this reset default value
			makeUnique = true
			pressed = true
	else:
		pressed = false
	
	#set cursor color
	if cursorState == "locked":
		cursorColor = Color(255,0,0)
	elif cursorState == "hovering":
		cursorColor = Color(255,255,255)
	else:
		cursorColor = Color(0,0,0)
	self.get_node("Cursor").set_modulate(cursorColor)
	
func getLaser():
	#check to see if index is in bounds
	if laserObjectIndex >= laserObjectPool.size():
		laserObjectIndex = 0
	#print(laserObjectIndex)
	laserObjectIndex += 1
	#print (laserObjectPool[laserObjectIndex-1].get_global_pos())
	#laserObjectPool[laserObjectIndex-1].set_global_pos(Vector2(0,0))
	return laserObjectPool[laserObjectIndex-1]
	
func _on_Button_button_down(type):
	if type == "Base":
		currentObject = "Base"
	elif type == "Base2":
		currentObject = "Base2"
	elif type == "Base3":
		currentObject = "Base3"
	elif type == "Mover":
		currentObject = "Mover"
	elif type == "Turrent":
		currentObject = "Turrent"
	elif type == "Attacker":
		currentObject = "Attacker"
	elif type == "Defender":
		currentObject = "Defender"

func set_hovering(state):
	overButton = state

func _on_Button_mouse_enter():
	overButton = true

func _on_Button_mouse_exit():
	overButton = false

func _on_Area2D_mouse_enter():
	overButton = true
	if cursorState != "locked":
		cursorState = "hovering"

func _on_Area2D_mouse_exit():
	overButton = false
	cursorState = ""

func _cusorStopFollowing():
	self.get_node("Cursor").followMouse = false

func _startFollowingMouse():
	self.get_node("Cursor").followMouse = true
