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
	
	print(top_boundary)
	#checks right boundary for Defender
	if self.global_position.x > right_boundary:
		self.global_position = Vector2(right_boundary, self.global_position.y)
	
	#checks left boundary for Defender
	if self.global_position.x < left_boundary:
		self.global_position = Vector2(left_boundary,self.global_position.y)
	
	#checks bottom boundary for Defender
	if self.global_position.y > bottom_boundary:
		self.global_position = Vector2(self.global_position.x, bottom_boundary)
	
	#checks bottom boundary for Defender
	if self.global_position.y < top_boundary:
		self.global_position = Vector2(self.global_position.x, top_boundary)

	current_speed.x = speedX
	current_speed.y = speedY
	#move the Defender
	var _colision = move_and_collide(current_speed)

	
func _ready():
	attacker = self.get_parent().get_parent().get_parent().get_node("AttackerArea/Attacker/KinematicBody2D/ShipSprite")
	set_physics_process(true)
	#if not in playing mode pause defender
	if GLOBALS.state != "Playing":
		print ("!!!!!!!!!!!!!!!!!!")
		self.pause_mode = true

func _physics_process(_delta):
	
	right_boundary = get_parent().get_node("rightBoundaryArea2D/rightBoundary").global_position.x - 42 #get_parent().get_child(3).get_child(0).global_position.x - 42
	left_boundary = get_parent().get_node("leftBoundaryArea2D/leftBoundary").global_position.x #get_parent().get_child(4).get_child(0).global_position.x + 42
	top_boundary = get_parent().get_node("topBoundaryArea2D/topBoundary").global_position.y + 42#get_parent().get_child(1).get_child(0).global_position.y + 42
	bottom_boundary = get_parent().get_node("bottomBoundaryArea2D/bottomBoundary").global_position.y - 42
	
	#rotate to protect bomber
	diff = attacker.global_position - self.global_position
	self.rotation = atan2(diff.y,diff.x) + 3.14/2
	
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
func collided(_dmg=0):
	
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

func _on_SpeedSpinBox_value_changed( value ):
	player_speed = value

func _on_HeightSpinBox_value_changed( value ):
	self.set_scale(Vector2(self.get_scale().x, value))

func _on_WidthSpinBox_value_changed( value ):
	self.set_scale(Vector2(value, self.get_scale().y))
