extends KinematicBody2D

# class member variables go here, for example:
var btn_right = false
var btn_left = false

var current_speed = Vector2(0,0)
var player_speed = GLOBALS.g_defense_spd #3
var left_boundary = GLOBALS.g_right_boundary #50
var right_boundary = GLOBALS.g_left_boundary #750
var shipPositionY

func collided():
	pass
	#set_linear_velocity(Vector2(current_speed.x,0))
func movement(speed):
	current_speed.x = speed
	
	#boundary for player 1 ------------------------------
	if self.global_position.x > right_boundary:
		self.global_position = (Vector2(right_boundary,shipPositionY))
		
	if self.global_position.x < left_boundary:
		self.global_position = (Vector2(left_boundary,shipPositionY))
	# ----------------------------------------------------
	
	move_and_collide(current_speed)
	#translate(current_speed)
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_physics_process(true)
	shipPositionY = self.global_position.y

func _physics_process(delta):
	if (GLOBALS.g_current_attacker == "player1"):
		btn_right = Input.is_action_pressed("Player2_Right")
		btn_left = Input.is_action_pressed("Player2_Left")
	
	else:
		btn_right = Input.is_action_pressed("Player1_Right")
		btn_left = Input.is_action_pressed("Player1_Left")
	
	if btn_right:
		movement(player_speed)
	if btn_left:
		movement(-player_speed)
