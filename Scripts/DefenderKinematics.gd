extends KinematicBody2D

# class member variables
var btn_right = false
var btn_left = false
var btn_up = false
var btn_down = false
var current_speed = Vector2(0,0)
var player_speed = GLOBALS.g_defense_spd
var left_boundary
var right_boundary
var top_boundary
var bottom_boundary
var shipPositionY
var isStunned = false
var stunTimer = 60
var defendingScoreLimit = 0
var attacker
var diff

#Gives movement to Defender
func movement(speedX, speedY):
	
	#checks right boundary for Defender
	if get_global_pos().x < right_boundary:
		set_global_pos(Vector2(right_boundary, get_global_pos().y))
	
	#checks left boundary for Defender
	if get_global_pos().x > left_boundary:
		set_global_pos(Vector2(left_boundary,get_global_pos().y))
	
	if get_global_pos().y > bottom_boundary:
		set_global_pos(Vector2(get_global_pos().x, bottom_boundary))
	
	if get_global_pos().y < top_boundary:
		set_global_pos(Vector2(get_global_pos().x, top_boundary))

	current_speed.x = speedX
	current_speed.y = speedY
	#move the Defender
	move(current_speed)

	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	right_boundary = get_parent().get_child(3).get_global_pos().x + 42
	left_boundary = get_parent().get_child(2).get_global_pos().x - 42
	top_boundary = get_parent().get_child(1).get_global_pos().y + 42
	bottom_boundary = get_parent().get_child(4).get_global_pos().y - 42
	
	attacker = self.get_parent().get_parent().get_node("Attacker/KinematicBody2D/ShipSprite")
	set_fixed_process(true)

func _fixed_process(delta):
	
	#rotate to protect bomber
	#diff = attacker.get_global_pos() - self.get_global_pos()
	#self.set_rot(atan2(-diff.y,diff.x) - 3.14/2)
	
	#Current Attacker is player1
	if (GLOBALS.g_current_attacker == "player1"):
		btn_right = Input.is_action_pressed("Player2_Right")
		btn_left = Input.is_action_pressed("Player2_Left")
		btn_up = Input.is_action_pressed("Player2_Up")
		btn_down = Input.is_action_pressed("Player2_Down")
	
	else:
		#Current Defender is player2
		btn_right = Input.is_action_pressed("Player1_Right")
		btn_left = Input.is_action_pressed("Player1_Left")
		btn_up = Input.is_action_pressed("Player1_Up")
		btn_down = Input.is_action_pressed("Player1_Down")
	
	#Defender is not stunned
	if(!isStunned):
		
		#Defender moves right
		if btn_right:
			movement(player_speed,0)
			
		#Defender moves left
		if btn_left:
			movement(-player_speed,0)
			
		if btn_down:
			movement(0,player_speed)
			
		if btn_up:
			movement(0, -player_speed)
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
	

