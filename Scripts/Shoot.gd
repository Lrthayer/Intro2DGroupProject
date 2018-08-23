extends Node2D


# class member variables go here, for example:
var firePressed = false
var laserObject = preload("res://Scenes/Laser.tscn")
var laserCount = 0
var laserOffset = 0
var bullet_speed = 1
var damage = GLOBALS.g_offense_dmg
var fireButton=0
var fireRate=0
var fireRateTimer = 0

var bulletHeight = 1
var bulletWidth = 1

#starts when loaded up in scene
func _ready():
	
	#current attacter is player1
	if (GLOBALS.g_current_attacker == "player1"):
		GLOBALS.g_current_attacker = "player2"
	else:
		GLOBALS.g_current_attacker = "player1"
		
	#current attacker is player1
	if (GLOBALS.g_current_attacker == "player1"):
		bullet_speed = GLOBALS.g_player1_spd
		damage = GLOBALS.g_player1_dmg
		fireRate = GLOBALS.g_player1_rate
	else:
		bullet_speed = GLOBALS.g_player2_spd
		damage = GLOBALS.g_player2_dmg
		fireRate = GLOBALS.g_player2_rate
	
	#set the fire rate
	if (fireRate == 1):
		fireRateTimer = 1
	elif (fireRate == 2):
		fireRateTimer = .5
	else:
		fireRateTimer = 0
	set_process(true)

#calls every frame
func _process(delta):
	
	fireRateTimer -= delta
	
	#Determine what button should be pressed for firing laser
	if (GLOBALS.g_current_attacker == "player1"):
		fireButton = Input.is_action_pressed("space_fire")
	else:
		fireButton = Input.is_action_pressed("right_fire")
	
	#Player is shooting laser
	if fireButton and !firePressed and fireRateTimer <= 0:
		
		laserCount += 1
		
		#create a copy of the laser object
		var laserInstance = laserObject.instance()
		laserInstance.set_scale(Vector2(bulletWidth, bulletWidth))
		laserInstance.speed = bullet_speed
		#set the fire rate
		if (fireRate == 1):
			fireRateTimer = 1
		elif (fireRate == 2):
			fireRateTimer = .5
		else:
			fireRateTimer = 0
		
		#give the copy a name 
		laserInstance.set_name("Laser" + str(laserCount))
		
		#add a child
		add_child(laserInstance)
		
		#set owner 
		laserInstance.set_owner(self)
		
		#set the position of the laser copy
		laserInstance.global_position = get_node("KinematicBody2D/ShipSprite").global_position + Vector2(0,24)
		
	#Check to see if user pressed the spacebar or Numpad 0
	firePressed = Input.is_action_pressed("space_fire") || Input.is_action_pressed("right_fire") 

func _on_DamageSpinBox_value_changed( value ):
	damage = value

func _on_FireRateSpinBox_value_changed( value ):
	fireRate = value

func _on_ProjSpeedSpinBox_value_changed( value ):
	bullet_speed = value

func _on_ProjHeightSpinBox_value_changed( value ):
	bulletHeight = value

func _on_ProjWidthSpinBox_value_changed( value ):
	bulletWidth = value