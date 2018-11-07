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

onready var specialBar = self.get_node("KinematicBody2D/special_bar")
var specialButton=false
var specialDuration= 3
var currentspecialDuration = specialDuration
export var specialTime = 5
var specialTemp = specialTime
var inSpecial = false

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
		
		
	#set special bar's max value to specialDuration
	specialBar.max_value = specialTime
	#set special Temp higher than speical Time so player can use special initially
	specialTemp = specialTime + 1
	set_process(true)

#calls every frame
func _process(delta):
	
	fireRateTimer -= delta
	
	#Determine what button should be pressed for firing laser
	if (GLOBALS.g_current_attacker == "player1"):
		fireButton = Input.is_action_pressed("space_fire")
		specialButton = Input.is_action_pressed("specialPower")
	else:
		fireButton = Input.is_action_pressed("right_fire")
		specialButton = Input.is_action_pressed("specialPower2")
	
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
		
	#if attacker is not using it's special and it's special isn't charged, charge special
	if !inSpecial and specialBar.value < specialBar.max_value:
		specialBar.value += delta
		specialTemp += delta
	#if user pressed the special power button make the sprite 50 percent opaque and turn off collisions
	if specialButton and specialTemp > specialTime:
		inSpecial = true
		specialTemp = 0
		self.get_node("KinematicBody2D/ShipSprite").modulate = Color(1,1,1,0.5)
		
	if inSpecial:
		specialBar.max_value = specialDuration
		currentspecialDuration -= delta
		#decrease special bar
		specialBar.value = (specialBar.value - delta)
		if currentspecialDuration <= 0:
			self.get_node("KinematicBody2D/ShipSprite").modulate = Color(1,1,1,1)
			currentspecialDuration = specialDuration
			#reset spceialBar
			#specialBar.value = specialDuration
			inSpecial = false
	#if not in special tell special bar to use the recharge time as it's new max value
	else:
		specialBar.max_value = specialTime
		
	#print ("special Time : ", specialTime, " specialBar : " ,specialBar.value) 
		
	#Check to see if user pressed the spacebar or Numpad 0
	firePressed = Input.is_action_pressed("space_fire") || Input.is_action_pressed("right_fire") 
	specialButton = false

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