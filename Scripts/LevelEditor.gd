extends Node2D

#placing vars
var turrent
var laser
var base
var base2
var base3 
var stun
var attacker
var defender
var image

#save and load vars
var packed_scene = PackedScene.new()
var dict = {}
var data 
var objectName
var childName = ""
var dir= ""
var isSaving = false
var isLoading = false
var numberOfSaves = 0
var addDirectory = [
"StatsVBox/HPHBox/HPSpinBox",
"StatsVBox/DamageHBox/DamageSpinBox",
"StatsVBox/FireRateHBox/FireRateSpinBox",
"StatsVBox/FireRateDeltaHBox/FireRateDeltaSpinBox",
"StatsVBox/SpeedHBox/SpeedSpinBox",
"StatsVBox/HeightHBox/HeightSpinBox",
"StatsVBox/WidthHBox/WidthSpinBox",
"ColorPicker",
"VisualVBox/HeightHBox/HeightSpinBox",
"VisualVBox/WidthHBox/WidthSpinBox",
"ColorPicker",
"ProjectileVBox/HeightHBox/HeightSpinBox",
"ProjectileVBox/WidthHBox/WidthSpinBox",
"ProjectileVBox/WidthHBox1/SpeedSpinBox",
"ProjectileVBox/WidthHBox1/ProjSpeedSpinBox",
"ProjectileVBox/WidthHBox2/ProjHeightSpinBox",
"ProjectileVBox/WidthHBox3/ProjWidthSpinBox"]

#state for placing vars
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

#starts when loaded up in scene
func _ready():
	if GLOBALS.changed_scene:
		GLOBALS.changed_scene = false
		
		if GLOBALS.isSaving:
			saving_level()
			loading_level("res://Scenes/temp.json")
		
		if GLOBALS.isLoading:
			loading_level("res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".json")
			saving_level()
		
		if GLOBALS.PressedCancelButton:
			loading_level("res://Scenes/temp.json")
		
	GLOBALS.isSaving = false
	GLOBALS.isLoading = false
	
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
	laser = self.get_node("TurretRayArea")
	stun = self.get_node("MoverArea")
	base = self.get_node("Base12D")
	base2 = self.get_node("Base22D")
	base3 = self.get_node("Base32D")
	attacker = self.get_node("AttackerArea")
	defender = self.get_node("DefenderArea")
	image = self.get_node("ImageArea2D")
	currentObject = "Turrent"

func loading_level(directory):
	#user is playing the level, take out camera and other related items
	if GLOBALS.isPlaying:
		self.get_node("Camera2D").hide()
		self.get_node("Cursor").hide()
		self.get_node("TurretArea").queue_free()
		self.get_node("TurretRayArea").queue_free()
		self.get_node("MoverArea").queue_free()
		self.get_node("Base12D").queue_free()
		self.get_node("Base22D").queue_free()
		self.get_node("Base32D").queue_free()
	#open json file
	data = {}
	var file = File.new()
	file.open(directory, file.READ)
	data = parse_json(file.get_line())
	
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
		
		self.get_node(dir).set_pick_color(c)
		
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
		
		self.get_node(dir).set_pick_color(c)
		
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
		
		self.get_node(dir).set_pick_color(c)
		
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
		
		self.get_node(dir).set_pick_color(c)
		
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
		
		self.get_node(dir).set_pick_color(c)
		
		dir = "Base3List/" +  childName + "/Base3/StaticBody2D/Sprite"
		self.get_node(dir)._on_ColorPicker_color_changed(c)
	
	#grab the properties of Laser Turrents
	for i in range(get_node("LaserList").get_child_count()):
		
		
		childName = get_node("LaserList").get_child(i).get_name()
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[0]
		
		self.get_node(dir).set_value(float(data[childName]["hp"]))
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[1]
		
		self.get_node(dir).set_value(float(data[childName]["damage"]))
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[8]
		
		self.get_node(dir).set_value(float(data[childName]["height"]))
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[9]
		
		self.get_node(dir).set_value(float(data[childName]["width"]))
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[10]
		
		#get color values
		r = float(data[childName]["colorR"])
		g = float(data[childName]["colorG"])
		b = float(data[childName]["colorB"])
		c = Color(r, g, b)
		
		self.get_node(dir).set_pick_color(c)
		
		dir = "LaserList/" +  childName + "/Turret/StaticBody2D/Sprite"
		self.get_node(dir)._on_ColorPicker_color_changed(c)
		
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[11]
		
		self.get_node(dir).set_value(float(data[childName]["proj_height"]))
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[12]
		
		self.get_node(dir).set_value(float(data[childName]["proj_width"]))
		
	#close the file
	file.close()
	
#called every frame
func _process(_delta):
	var mosLoc = self.get_global_mouse_position()
	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		self.get_node("CanvasLayer/PauseMenu").show()
		GLOBALS.last_scene = "pause"
	
	if  !overButton && Input.is_key_pressed(KEY_P):
		if !overButton && !pressed && editorState == "placing":
			var objectInstance = null
			var offset = Vector2(130,20)
			#objectInstance.visible = true
			if currentObject == "Base":
				objectInstance = base.duplicate()
			elif currentObject == "Base2":
				objectInstance = base2.duplicate()
			elif currentObject == "Base3":
				objectInstance = base3.duplicate()
			elif currentObject == "Mover":
				objectInstance = stun.duplicate()
			elif currentObject == "Turrent":
				objectInstance = turrent.duplicate()
			elif currentObject == "Laser":
				objectInstance = laser.duplicate()
			elif currentObject == "Attacker":
				objectInstance = attacker
				makeUnique = false
			elif currentObject == "Defender":
				objectInstance = defender
				makeUnique = false
			elif currentObject == "Image":
				#get file
				self.get_node("CanvasLayer/customButtonFileDialog").popup()
				#we will place the object in the slot connected to customButtonFileDialog slot in this file line: 858 appr.
				
				#since we handle this placement in the slot leave before trying to place, reset press before leaving
				pressed = true
				return
			if makeUnique:
				#change mouse location to center object with cursor 
				mosLoc.x -= offset.x
				mosLoc.y += offset.y
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
	if GLOBALS.isPlaying == false:
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
		elif type == "Laser":
			currentObject = "Laser"
		elif type == "Image":
			currentObject = "Image"

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

func _on_Area2D_mouse_exit():
	if !overButtonLock:
		overButton = false
	cursorState = ""

func _cusorStopFollowing():
	self.get_node("Cursor").followMouse = false

func _startFollowingMouse():
	self.get_node("Cursor").followMouse = true

func saving_level():
	
	packed_scene.pack(get_tree().get_current_scene())
	
	#varibles
	var objects = {}

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

		c = self.get_node(dir).get_pick_color()

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
		
		c = self.get_node(dir).get_pick_color()
		
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
		
		c = self.get_node(dir).get_pick_color()
		
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
		
		c = self.get_node(dir).get_pick_color()
		
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
		
		c = self.get_node(dir).get_pick_color()
		
		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		
		dict[childName] = objects
		objects = {}
		
	#grab the properties of laser turrent
	for n in range(get_node("LaserList").get_child_count()):
		
		childName = get_node("LaserList").get_child(n).get_name()
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[0]
		
		objects["hp"] = str(self.get_node(dir).get_value())
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[1]
		
		objects["damage"] = str(self.get_node(dir).get_value())
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[8]
		
		objects["height"] = str(self.get_node(dir).get_value())
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[9]
		
		objects["width"] = str(self.get_node(dir).get_value())
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[10]
		
		c = self.get_node(dir).get_pick_color()
		
		objects["colorR"] = str(c[0])
		objects["colorG"] = str(c[1])
		objects["colorB"] = str(c[2])
		
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[11]
		
		objects["proj_height"] = str(self.get_node(dir).get_value())
		dir = "LaserList/" +  childName + "/TurrentMenu/" + addDirectory[12]

		objects["proj_width"] = str(self.get_node(dir).get_value())
		
		
		dict[childName] = objects
		objects = {}
		
		
	var file = File.new()
	
	#load the directory
	var directory = Directory.new()
	
	if GLOBALS.isSaving:
		#for some reason saving it to its folder is not working. Idea to fix problem. copy temp json which has right values for some reason
		#print("res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".json")
		#file.open("res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".json" , file.WRITE)
		#file.store_line(to_json(dict))
		#file.close()
		directory.copy("res://Scenes/temp.json", "res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".json")
		var saveErr : int = ResourceSaver.save("res://Playlists/" + GLOBALS.current_playlist_name + "/" + str(GLOBALS.g_current_level) + "/" + GLOBALS.current_level_name + ".tscn" , packed_scene)
		if saveErr != 0:
			print ("save error " + str(saveErr))
	else:
		file.open("res://Scenes/temp.json", file.WRITE)
		file.store_line(to_json(dict))
		file.close()
		var saveErr : int = ResourceSaver.save("res://Scenes/temp.tscn", packed_scene)
		if saveErr != 0:
			print("save error " + str(saveErr))

func _on_Save_Button_pressed():
	GLOBALS.changed_scene = true
	
	#save the temp scene
	saving_level()
	var directory = Directory.new()
	if !directory.dir_exists("res://Playlists"):
		directory.make_dir("res://Playlists")

	directory.open("user://Playlists/")
	
	directory.list_dir_begin(true,true)
	var file = directory.get_next()
	directory.list_dir_end()
	
	GLOBALS.changed_scene = true
	
	if file == "" ||  GLOBALS.current_level_name == "Default":
		var _changeSceneErr = get_tree().change_scene("res://Scenes/Save_Interface/Save.tscn")
	else:
		var _changeSceneErr = get_tree().change_scene("res://Scenes/Save_Interface/Save2.tscn")
	
func _on_Load_Button_pressed():
	
	#load the directory
	var directory = Directory.new()
	
	if !directory.dir_exists("res://Playlists"):
		directory.make_dir("res://Playlists")
		
	directory.open("user://Playlists/")
	
	directory.list_dir_begin(true,true)
	var file = directory.get_next()
	directory.list_dir_end()

	#check the directory
	if file == "":
		self.get_node("Camera2D/Control/AcceptDialog").show()
		self.get_node("Camera2D/Control/AcceptDialog").rect_position = Vector2(self.get_node("Camera2D").position.x + 50,self.get_node("Camera2D").position.y -50)
		self.get_node("Camera2D/Control").mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		GLOBALS.changed_scene = true
		saving_level()
		var _sceneChangeErr = get_tree().change_scene("res://Scenes/Load_Interface/load.tscn")

#user clicked okay
func _on_AcceptDialog_confirmed():
	self.get_node("Camera2D/Control").mouse_filter = Control.MOUSE_FILTER_IGNORE

#user clicked X
func _on_AcceptDialog_hide():
	self.get_node("Camera2D/Control").mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_customButtonFileDialog_file_selected(path):
	var objectInstance = image.duplicate()
	objectInstance.visible = true
	#get file
	var tex = ImageTexture.new()
	var img = Image.new()
	print (self.get_node("CanvasLayer/customButtonFileDialog").current_path)
	img.load(self.get_node("CanvasLayer/customButtonFileDialog").current_path)
	tex.create_from_image(img)
	objectInstance.get_node("TextureRect").set_texture(tex)
	var offset = objectInstance.get_node("TextureRect").rect_size/2
	print ("offset: " + str(offset))
	#change mouse location to center object with cursor 
	var mosLoc = self.get_global_mouse_position()
	print(mosLoc)
	mosLoc.x -= offset.x
	mosLoc.y += offset.y
	print (str(mosLoc))
	objectInstance.global_position = mosLoc
	
	#give the copy a name 
	objectInstance.set_name(currentObject + str(objectIndex))
	self.get_node(currentObject + "List").add_child(objectInstance)
	objectInstance.set_owner(self)
	objectIndex += 1
