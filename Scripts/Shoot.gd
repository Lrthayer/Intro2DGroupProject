extends Node2D

# class member variables go here, for example:
var firePressed = false
var laserObject = preload("res://Scenes/Laser.tscn")
var laserCount = 0
var fireButton

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	
		#user pressed spacebar
	if (GLOBALS.g_current_attacker == "player1"):
		fireButton = Input.is_action_pressed("space_fire")
	else:
		fireButton = Input.is_action_pressed("0_fire")
	
	if fireButton and !firePressed:
		
		laserCount += 1
		
		#create a copy of the laser object
		var laserInstance = laserObject.instance()
		
		
		#give the copy a name 
		laserInstance.set_name("Laser" + str(laserCount))
		
		
		
		#add a child
		add_child(laserInstance)
	
	
		laserInstance.set_owner(self)
		
		
		
		#set the position of the laser copy
		laserInstance.set_global_pos(get_node("KinematicBody2D/ShipSprite").get_global_pos() + Vector2(0,24))
	
		
		
	#Check to see if user pressed the spacebar	
	firePressed = Input.is_action_pressed("space_fire") || Input.is_action_pressed("0_fire") 