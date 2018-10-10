extends Node2D
#var turrent = preload("res://Scenes/Turret.tscn")
var turrent
#var base = preload("res://Scenes/Base1.tscn")
var base
#var base2 = preload("res://Scenes/Base2.tscn")
var base2
var base3 
#var ground = preload("res://Scenes/Turret.tscn")
#var stun = preload("res://Scenes/MoverLevelEditor.tscn")
#var laser = preload("enemyLaserLevelEditor.tscn")
var stun
var attacker
var defender

var packed_scene = PackedScene.new()
var dict = {}
var data 
var objectName
var childName = ""
var dir= ""
var isSaving = true
var save_scene1 = load("res://Save.tscn")
var save_scene2 = load("res://Save2.tscn")

var addDirectory = ["StatsVBox/HPHBox/HPSpinBox","StatsVBox/DamageHBox/DamageSpinBox",
"StatsVBox/FireRateHBox/FireRateSpinBox","StatsVBox/FireRateDeltaHBox/FireRateDeltaSpinBox",
"StatsVBox/SpeedHBox/SpeedSpinBox","StatsVBox/HeightHBox/HeightSpinBox",
"StatsVBox/WidthHBox/WidthSpinBox","ColorPicker","VisualVBox/HeightHBox/HeightSpinBox",
"VisualVBox/WidthHBox/WidthSpinBox","ColorPicker","ProjectileVBox/HeightHBox/HeightSpinBox",
"ProjectileVBox/WidthHBox/WidthSpinBox","ProjectileVBox/WidthHBox1/SpeedSpinBox",
"ProjectileVBox/WidthHBox1/ProjSpeedSpinBox","ProjectileVBox/WidthHBox2/ProjHeightSpinBox",
"ProjectileVBox/WidthHBox3/ProjWidthSpinBox"]

#add a child
#get_parent().add_child(laserInstance)
var currentObject
var objectIndex = 0
var overButton = false
var overButtonLock = false
var pressed = false

var cursorColor = Color(0,0,0)
var cursorState = ""

var makeUnique = true

var editorState = "placing"

#Laser Object bool
var laserObjectPool = []
var laserObjectIndex = 0
var laserObjectPoolAmount = 50

var numberOfSaves = 0

#starts when loaded up in scene
func _ready():
	
	#setup screen capture, for level saving/playlist
	#get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	#yield(get_tree(), "idle_frame")
	#yield(get_tree(), "idle_frame")
	
	if GLOBALS.changed_scene:
		
		#open json file
		data = {}
		var file = File.new()
		file.open("res://meow5.json", file.READ)
		data = parse_json(file.get_line())
		#data.parse_json(file.get_line())
		
		#grab the properties of attacker
		dir = "AttackerArea/AttackerMenu/" + addDirectory[0]
		self.get_node(dir).set_value(float(data["AttackerArea"]["hp"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[1]
		self.get_node(dir).set_value(float(data["AttackerArea"]["damage"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[2]
		self.get_node(dir).set_value(float(data["AttackerArea"]["fire_rate"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[4]
		self.get_node(dir).set_value(float(data["AttackerArea"]["speed"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[8]
		self.get_node(dir).set_value(float(data["AttackerArea"]["height"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[9]
		self.get_node(dir).set_value(float(data["AttackerArea"]["width"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[10]
		
		#get color values
		var r = float(data["AttackerArea"]["colorR"])
		var g = float(data["AttackerArea"]["colorG"])
		var b = float(data["AttackerArea"]["colorB"])
		var c = Color(r, g, b)
		self.get_node(dir).color = c
				
		#add the color to sprite
		dir = "AttackerArea/Attacker/KinematicBody2D/ShipSprite"
		self.get_node(dir)._on_ColorPicker_color_changed(c)
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[14]
		self.get_node(dir).set_value(float(data["AttackerArea"]["proj_speed"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[15]
		self.get_node(dir).set_value(float(data["AttackerArea"]["proj_height"]))
		
		dir = "AttackerArea/AttackerMenu/" + addDirectory[16]
		self.get_node(dir).set_value(float(data["AttackerArea"]["proj_width"]))
		
		#grab the properties of defender
		dir = "DefenderArea/DefenderMenu/" + addDirectory[2]
		self.get_node(dir).set_value(float(data["DefenderArea"]["fire_rate"]))
		
		dir = "DefenderArea/DefenderMenu/" + addDirectory[4]
		self.get_node(dir).set_value(float(data["DefenderArea"]["speed"]))
		
		dir = "DefenderArea/DefenderMenu/" + addDirectory[8]
		self.get_node(dir).set_value(float(data["DefenderArea"]["height"]))
		
		
		dir = "DefenderArea/DefenderMenu/" + addDirectory[9]
		self.get_node(dir).set_value(float(data["DefenderArea"]["width"]))
		
		dir = "DefenderArea/DefenderMenu/" + addDirectory[10]
		
		#get color values
		r = float(data["DefenderArea"]["colorR"])
		g = float(data["DefenderArea"]["colorG"])
		b = float(data["DefenderArea"]["colorB"])
		c = Color(r, g, b)
		self.get_node(dir).color = c
		
		#add the color to sprite 
		dir = "DefenderArea/Defender/KinematicBody2D/DefenderSprite"
		self.get_node(dir)._on_ColorPicker_color_changed(c)
		
		
		#grab the properties of turrets
		for i in range(get_node("TurrentList").get_child_count()):
			
			childName = get_node("TurrentList").get_child(i).get_name()
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[0]
			
			self.get_node(dir).set_value(float(data[childName]["hp"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[1]
			
			self.get_node(dir).set_value(float(data[childName]["damage"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[2]
			
			self.get_node(dir).set_value(float(data[childName]["fire_rate"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[3]
			
			self.get_node(dir).set_value(float(data[childName]["fire_rate_delta"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[8]
			
			self.get_node(dir).set_value(float(data[childName]["height"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[9]
			
			self.get_node(dir).set_value(float(data[childName]["width"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[10]
			
			#get color values
			r = float(data[childName]["colorR"])
			g = float(data[childName]["colorG"])
			b = float(data[childName]["colorB"])
			c = Color(r, g, b)
			
			self.get_node(dir).set_color(c)
			
			dir = "TurrentList/" +  childName + "/Turret/StaticBody2D/Sprite"
			self.get_node(dir)._on_ColorPicker_color_changed(c)
			
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[11]
			
			self.get_node(dir).set_value(float(data[childName]["proj_height"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[12]
			
			self.get_node(dir).set_value(float(data[childName]["proj_width"]))
			dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[13]
			
			self.get_node(dir).set_value(float(data[childName]["proj_speed"]))
			
			
		#grab the properties of movers
		for j in range(get_node("MoverList").get_child_count()):
			
			childName = get_node("MoverList").get_child(j).get_name()
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[0]
			
			self.get_node(dir).set_value(float(data[childName]["hp"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[1]
			
			self.get_node(dir).set_value(float(data[childName]["damage"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[2]
			
			self.get_node(dir).set_value(float(data[childName]["fire_rate"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[3]
			
			self.get_node(dir).set_value(float(data[childName]["fire_rate_delta"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[4]
			
			self.get_node(dir).set_value(float(data[childName]["speed"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[8]
			
			self.get_node(dir).set_value(float(data[childName]["height"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[9]
			
			self.get_node(dir).set_value(float(data[childName]["width"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[10]
			
			#get color values
			r = float(data[childName]["colorR"])
			g = float(data[childName]["colorG"])
			b = float(data[childName]["colorB"])
			c = Color(r, g, b)
			
			self.get_node(dir).set_color(c)
			
			dir = "MoverList/" +  childName + "/Mover/KinematicBody2D/Sprite"
			self.get_node(dir)._on_ColorPicker_color_changed(c)
			
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[14]
			
			self.get_node(dir).set_value(float(data[childName]["proj_speed"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[16]
			
			self.get_node(dir).set_value(float(data[childName]["proj_width"]))
			dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[15]
			
			self.get_node(dir).set_value(float(data[childName]["proj_height"]))
			
		#grab the properties of base1
		for k in range(get_node("BaseList").get_child_count()):
			
			childName = get_node("BaseList").get_child(k).get_name()
			dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[0]
			
			self.get_node(dir).set_value(float(data[childName]["hp"]))
			dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[5]
			
			self.get_node(dir).set_value(float(data[childName]["height"]))
			dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[6]
			
			self.get_node(dir).set_value(float(data[childName]["width"]))
			dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[7]
			
			#get color values
			r = float(data[childName]["colorR"])
			g = float(data[childName]["colorG"])
			b = float(data[childName]["colorB"])
			c = Color(r, g, b)
			
			self.get_node(dir).set_color(c)
			
			dir = "BaseList/" +  childName + "/Base1/StaticBody2D/Sprite"
			self.get_node(dir)._on_ColorPicker_color_changed(c)
			
		#grab the properties of base2
		for l in range(get_node("Base2List").get_child_count()):
			
			childName = get_node("Base2List").get_child(l).get_name()
			dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[0]
			
			self.get_node(dir).set_value(float(data[childName]["hp"]))
			dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[5]
			
			self.get_node(dir).set_value(float(data[childName]["height"]))
			dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[6]
			
			self.get_node(dir).set_value(float(data[childName]["width"]))
			dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[7]
			
			#get color values
			r = float(data[childName]["colorR"])
			g = float(data[childName]["colorG"])
			b = float(data[childName]["colorB"])
			c = Color(r, g, b)
			
			self.get_node(dir).set_color(c)
			
			dir = "Base2List/" +  childName + "/Base2/StaticBody2D/Sprite"
			self.get_node(dir)._on_ColorPicker_color_changed(c)
			
		#grab the properties of base3
		for m in range(get_node("Base3List").get_child_count()):
			
			childName = get_node("Base3List").get_child(m).get_name()
			dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[0]
			
			self.get_node(dir).set_value(float(data[childName]["hp"]))
			dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[5]
			
			self.get_node(dir).set_value(float(data[childName]["height"]))
			dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[6]
			
			self.get_node(dir).set_value(float(data[childName]["width"]))
			dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[7]
			
			#get color values
			r = float(data[childName]["colorR"])
			g = float(data[childName]["colorG"])
			b = float(data[childName]["colorB"])
			c = Color(r, g, b)
			
			self.get_node(dir).set_color(c)
			
			dir = "Base3List/" +  childName + "/Base3/StaticBody2D/Sprite"
			self.get_node(dir)._on_ColorPicker_color_changed(c)
		#close the file
		file.close()
		
	GLOBALS.changed_scene = false
	
	set_process(true)
		#create laserObject pool
	for i in range(laserObjectPoolAmount):
		laserObjectPool.append(self.get_node("/root/Main/TurretArea/TurrentMenu/ProjectileVBox/Laser").duplicate())
		#laserObjectPool.append(laser.instance())
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
	currentObject = "Turrent"

#called every frame
func _process(delta):
	var mosLoc = self.get_global_mouse_position()
	var posOffset = Vector2(mosLoc.x-20, mosLoc.y-20)
	#get_child(1).set_global_pos(posOffset)
	if  !overButton && Input.is_key_pressed(KEY_P):
		if !overButton && !pressed && editorState == "placing":
			var objectInstance = null
			#objectInstance.visible = true
			#objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
			#objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			#we have to manually copy signals over
			if currentObject == "Base":
				objectInstance = base.duplicate()
				objectInstance.visible = true
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Base2":
				objectInstance = base2.duplicate()
				objectInstance.visible = true
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Base3":
				objectInstance = base3.duplicate()
				objectInstance.visible = true
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Mover":
				objectInstance = stun.duplicate()
				objectInstance.visible = true
				objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_child(0).get_child(1).connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_child(0).get_child(1).connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_child(0).get_child(2).connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				objectInstance.get_child(0).get_child(2).connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				objectInstance.get_node("MoverMenu/VisualVBox/HeightHBox/HeightSpinBox").connect("value_changed", objectInstance.get_node("/root/MoverArea/Mover"), "_on_height_value_changed")
				objectInstance.get_node("MoverMenu/VisualVBox/WidthHBox/WidthSpinBox").connect("value_changed", objectInstance.get_node("/root/MoverArea/Mover"), "_on_width_value_changed")
				#objectInstance.get_node("MoverMenu/ColorPickerArea2D/ColorPicker").connect("color_changed", objectInstance.get_node("/root/MoverArea/Mover/KinematicBody2D/Sprite"), "_on_ColorPickerButton_color_changed")
				#objectInstance.get_node("MoverMenu/ColorPickerArea2D").connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				#objectInstance.get_node("MoverMenu/ColorPickerArea2D").connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Turrent":
				#objectInstance = turrent.duplicate(8)
				objectInstance = turrent.duplicate()
				objectInstance.visible = true
				#objectInstance.connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				#objectInstance.connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				#objectInstance.get_node("TurrentMenu").connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				#objectInstance.get_node("TurrentMenu").connect("mouse_exit", self, "_on_Area2D_mouse_exit")
				#objectInstance.get_node("TurrentMenu").connect("mouse_enter", self.get_node("Cursor"), "_on_Hide_mouse_enter")
				#objectInstance.get_node("TurrentMenu").connect("mouse_exit", self.get_node("Cursor"), "_on_unHide_mouse_exit")
				#objectInstance.get_node("TurrentMenu/VisualVBox/HeightHBox/HeightSpinBox").connect("value_changed", objectInstance.get_node("TurrentMenu/VisualVBox/HeightHBox/HeightSpinBox").get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_height_value_changed")
				#objectInstance.get_node("TurrentMenu/VisualVBox/WidthHBox/WidthSpinBox").connect("value_changed", objectInstance.get_node("TurrentMenu/VisualVBox/WidthHBox/WidthSpinBox").get_parent().get_parent().get_parent().get_parent().get_parent(), "_on_width_value_changed")
				#objectInstance.get_node("TurrentMenu/ColorPickerArea2D/ColorPicker").connect("color_changed", objectInstance.get_node("/root/TurrentArea/Turret/StaticBody2D/Sprite"), "_on_ColorPickerButton_color_changed")
				#objectInstance.get_node("TurrentMenu/ColorPickerArea2D").connect("mouse_enter", self, "_on_Area2D_mouse_enter")
				#objectInstance.get_node("TurrentMenu/ColorPickerArea2D").connect("mouse_exit", self, "_on_Area2D_mouse_exit")
			elif currentObject == "Attacker":
				objectInstance = attacker
				objectInstance.visible = true
				makeUnique = false
			elif currentObject == "Defender":
				objectInstance = defender
				objectInstance.visible = true
				makeUnique = false

			if makeUnique:
				#change mouse location to center object with cursor 
				mosLoc.x -= 130
				mosLoc.y += 20
				objectInstance.global_position = mosLoc
				
				#give the copy a name 
				objectInstance.set_name(currentObject + str(objectIndex))
				self.get_node(currentObject + "List").add_child(objectInstance)
				objectInstance.set_owner(self)
				objectIndex += 1
			else:
				objectInstance.global_position = mosLoc

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
	if !overButtonLock:
		overButton = state

func _on_Button_mouse_enter():
	if !overButtonLock:
		overButton = true

func _on_Button_mouse_exit():
	if !overButtonLock:
		overButton = false

func _on_Area2D_mouse_enter():
	if !overButtonLock:
		overButton = true
	if cursorState != "locked":
		cursorState = "hovering"
	print("locked")

func _on_Area2D_mouse_exit():
	if !overButtonLock:
		overButton = false
	cursorState = ""
	print("unlocked")

func _cusorStopFollowing():
	self.get_node("Cursor").followMouse = false

func _startFollowingMouse():
	self.get_node("Cursor").followMouse = true

func _on_Save_Button_pressed():
	packed_scene.pack(get_tree().get_current_scene())
	
	#varibles
	var objects = {}
	var numOfObjects = 0
	
	var sav_obj = save_scene1.instance()
	self.add_child(sav_obj)
	
	#saving interface
	
	#grab the properties of attacker
	dir = "AttackerArea/AttackerMenu/" + addDirectory[0]
	objects["hp"] = str(self.get_node(dir).get_value())
	
	dir = "AttackerArea/AttackerMenu/" + addDirectory[1]
	objects["damage"] = str(self.get_node(dir).get_value())
	
	dir = "AttackerArea/AttackerMenu/" + addDirectory[2]
	objects["fire_rate"] = str(self.get_node(dir).get_value())
	
	dir = "AttackerArea/AttackerMenu/" + addDirectory[4]
	objects["speed"] = str(self.get_node(dir).get_value())
	
	dir = "AttackerArea/AttackerMenu/" + addDirectory[8]
	objects["height"] = str(self.get_node(dir).get_value())

	dir = "AttackerArea/AttackerMenu/" + addDirectory[9]
	objects["width"] = str(self.get_node(dir).get_value())

	dir = "AttackerArea/AttackerMenu/" + addDirectory[10]
	var c = self.get_node(dir).color

	objects["colorR"] = str(c[0])
	objects["colorG"] = str(c[1])
	objects["colorB"] = str(c[2])

	dir = "AttackerArea/AttackerMenu/" + addDirectory[14]
	objects["proj_speed"] = str(self.get_node(dir).get_value())

	dir = "AttackerArea/AttackerMenu/" + addDirectory[15]
	objects["proj_height"] = str(self.get_node(dir).get_value())

	dir = "AttackerArea/AttackerMenu/" + addDirectory[16]
	objects["proj_width"] = str(self.get_node(dir).get_value())
	
	dict["AttackerArea"] = objects
	objects = {}

	#grab the properties of defender
	dir = "DefenderArea/DefenderMenu/" + addDirectory[2]
	objects["fire_rate"] = str(self.get_node(dir).get_value())

	dir = "DefenderArea/DefenderMenu/" + addDirectory[4]
	objects["speed"] = str(self.get_node(dir).get_value())

	dir = "DefenderArea/DefenderMenu/" + addDirectory[8]
	objects["height"] = str(self.get_node(dir).get_value())

	dir = "DefenderArea/DefenderMenu/" + addDirectory[9]
	objects["width"] = str(self.get_node(dir).get_value())

	dir = "DefenderArea/DefenderMenu/" + addDirectory[10]
	c = self.get_node(dir).color

	objects["colorR"] = str(c[0])
	objects["colorG"] = str(c[1])
	objects["colorB"] = str(c[2])

	dict["DefenderArea"] = objects
	objects = {}
	#grab the properties of turrets
	for i in range(get_node("TurrentList").get_child_count()):
		
		childName = get_node("TurrentList").get_child(i).get_name()
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[0]

		objects["hp"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[1]

		objects["damage"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[2]

		objects["fire_rate"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[3]

		objects["fire_rate_delta"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[8]

		objects["height"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[9]

		objects["width"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[10]

		c = self.get_node(dir).get_color()

		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[11]

		objects["proj_height"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[12]

		objects["proj_width"] = str(self.get_node(dir).get_value())
		dir = "TurrentList/" +  childName + "/TurrentMenu/" + addDirectory[13]

		objects["proj_speed"] = str(self.get_node(dir).get_value())

		dict[childName] = objects
		objects = {}

	#grab the properties of movers
	for j in range(get_node("MoverList").get_child_count()):
		
		childName = get_node("MoverList").get_child(j).get_name()
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[0]
		
		objects["hp"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[1]
		
		objects["damage"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[2]
		
		objects["fire_rate"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[3]
		
		objects["fire_rate_delta"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[4]
		
		objects["speed"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[8]
		
		objects["height"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[9]
		
		objects["width"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[10]
		
		c = self.get_node(dir).get_color()
		
		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[14]
		
		objects["proj_speed"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[16]
		
		objects["proj_width"] = str(self.get_node(dir).get_value())
		dir = "MoverList/" +  childName + "/MoverMenu/" + addDirectory[15]
		
		objects["proj_height"] = str(self.get_node(dir).get_value())
			
		dict[childName] = objects
		objects = {}
	
	#grab the properties of Base1
	for k in range(get_node("BaseList").get_child_count()):
		
		childName = get_node("BaseList").get_child(k).get_name()
		dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[0]
		
		objects["hp"] = str(self.get_node(dir).get_value())
		dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[5]
		
		objects["height"] = str(self.get_node(dir).get_value())
		dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[6]
		
		objects["width"] = str(self.get_node(dir).get_value())
		dir = "BaseList/" +  childName + "/Base1Menu/" + addDirectory[7]
		
		c = self.get_node(dir).get_color()
		
		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		
		dict[childName] = objects
		objects = {}
		
	#grab the properties of Base2
	for l in range(get_node("Base2List").get_child_count()):
		
		childName = get_node("Base2List").get_child(l).get_name()
		dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[0]
		
		objects["hp"] = str(self.get_node(dir).get_value())
		dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[5]
		
		objects["height"] = str(self.get_node(dir).get_value())
		dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[6]
		
		objects["width"] = str(self.get_node(dir).get_value())
		dir = "Base2List/" +  childName + "/Base2Menu/" + addDirectory[7]
		
		c = self.get_node(dir).get_color()
		
		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		
		dict[childName] = objects
		objects = {}
	
	#grab the properties of Base3
	for m in range(get_node("Base3List").get_child_count()):
		
		childName = get_node("Base3List").get_child(m).get_name()
		dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[0]
		
		objects["hp"] = str(self.get_node(dir).get_value())
		dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[5]
		
		objects["height"] = str(self.get_node(dir).get_value())
		dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[6]
		
		objects["width"] = str(self.get_node(dir).get_value())
		dir = "Base3List/" +  childName + "/Base3Menu/" + addDirectory[7]
		
		c = self.get_node(dir).get_color()
		
		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		
		dict[childName] = objects
		objects = {}
	
	var file = File.new()
	file.open("res://meow5.json", file.WRITE)
	file.store_line(to_json(dict))
	file.close()
	ResourceSaver.save("res://myscene.tscn", packed_scene)
	
	# get screen capture
	var capture = get_viewport().get_texture().get_data()
	capture.flip_y()
	# save to a file
	capture.save_png("res://screenshot" + str(numberOfSaves) + ".png")
	#tell playlist to add pic for level
	#self.get_node("Camera2D").get_node("playlist").save_item(capture)
	#numberOfSaves = numberOfSaves + 1

func _on_Load_Button_pressed():
	GLOBALS.file_name = "myscene"
	GLOBALS.changed_scene = true
	get_tree().change_scene("res://myscene.tscn")
