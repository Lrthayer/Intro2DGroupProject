extends Node2D

onready var specialBar = self.get_node("KinematicBody2D/special_bar")
var specialButton=false
var specialDuration= 3
var currentspecialDuration = specialDuration
export var specialTime = 5
var specialTemp = specialTime
var inSpecial = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#set special bar's max value to specialDuration
	specialBar.max_value = specialTime
	#set special Temp higher than speical Time so player can use special initially
	specialTemp = specialTime + 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		#Determine what button should be pressed for firing laser
	if (GLOBALS.g_current_attacker == "player1"):
		specialButton = Input.is_action_pressed("specialPower2")
	else:
		specialButton = Input.is_action_pressed("specialPower")
	
	#if attacker is not using it's special and it's special isn't charged, charge special
	if !inSpecial and specialBar.value < specialBar.max_value:
		specialBar.value += delta
		specialTemp += delta
	#if user pressed the special power button make the sprite 50 percent opaque and turn off collisions
	if specialButton and specialTemp > specialTime:
		inSpecial = true
		specialTemp = 0
	elif specialButton and specialTemp < specialTime:
		print(specialTemp)
		print(specialTime)

	if inSpecial:
		self.get_node("KinematicBody2D/DefenderShieldStaticBody2D").reflect = true
		specialBar.max_value = specialDuration
		currentspecialDuration -= delta
		#decrease special bar
		specialBar.value = (specialBar.value - delta)
		if currentspecialDuration <= 0:
			currentspecialDuration = specialDuration
			inSpecial = false
	#if not in special tell special bar to use the recharge time as it's new max value
	else:
		specialBar.max_value = specialTime
		self.get_node("KinematicBody2D/DefenderShieldStaticBody2D").reflect = false
		
	if specialBar.value == specialBar.max_value:
		specialTemp = specialTime + 1
