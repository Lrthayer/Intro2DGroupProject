extends KinematicBody2D

# class member variables
var btn_right = false
var btn_left = false
var current_speed = Vector2(0,0)
var player_speed = GLOBALS.g_defense_spd
var left_boundary = GLOBALS.g_right_boundary 
var right_boundary = GLOBALS.g_left_boundary 
var shipPositionY
var isStunned = false
var stunTimer = 60
var defendingScoreLimit = 0

#Gives movement to Defender
func movement(speed):
	current_speed.x = speed
	
	#checks right boundary for Defender
	if get_global_pos().x > right_boundary:
		set_global_pos(Vector2(right_boundary,shipPositionY))
	
	#checks left boundary for Defender
	if get_global_pos().x < left_boundary:
		set_global_pos(Vector2(left_boundary,shipPositionY))

	#move the Defender
	move(current_speed)

	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	shipPositionY = get_global_pos().y

func _fixed_process(delta):
	
	#Current Attacker is player1
	if (GLOBALS.g_current_attacker == "player1"):
		btn_right = Input.is_action_pressed("Player2_Right")
		btn_left = Input.is_action_pressed("Player2_Left")
	
	else:
		#Current Defender is player2
		btn_right = Input.is_action_pressed("Player1_Right")
		btn_left = Input.is_action_pressed("Player1_Left")
	
	#Defender is not stunned
	if(!isStunned):
		
		#Defender moves right
		if btn_right:
			movement(player_speed)
			
		#Defender moves left
		if btn_left:
			movement(-player_speed)
	else:
		stunTimer-=1
		
		if(stunTimer < 0):
			isStunned = false
			stunTimer = 60

#defender is colliding with another object
func collided(dmg=0):
	
	# defender score has not reached the cap
	if defendingScoreLimit < 1500:
		
		#defender score goes to the right player
		if GLOBALS.g_current_attacker == "player2":
			GLOBALS.g_player1_defender_score += 100
			defendingScoreLimit += 100
		else:
			GLOBALS.g_player2_defender_score += 100
			defendingScoreLimit += 100
	

#Defender is stunned by laser
func stunned():
	isStunned = true
	

