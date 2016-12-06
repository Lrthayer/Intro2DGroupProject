extends KinematicBody2D

# class member variables
var btn_right = false
var btn_left = false
var current_speed = Vector2(0,0)
var player_speed
var left_boundary = GLOBALS.g_right_boundary 
var right_boundary = GLOBALS.g_left_boundary 
var hp = GLOBALS.g_offense_hp
var shipPositionY
var isStunned = false
var stunTimer = 60


#Gives movement to Attacker
func movement(speed):
	
	current_speed.x = speed
	
	#check right side boundary for Attacker
	if get_global_pos().x > right_boundary:
		set_global_pos(Vector2(right_boundary,shipPositionY))

	#check left side boundary for Attacker
	if get_global_pos().x < left_boundary:
		set_global_pos(Vector2(left_boundary,shipPositionY))

	#move the Attacker
	move(current_speed)

#Starts when scene is loaded 
func _ready():
	
	get_node("hp_bar").set_max(hp)
	shipPositionY = get_global_pos().y
	set_fixed_process(true)
	
	if (GLOBALS.g_current_attacker == "player1"):
		player_speed = GLOBALS.g_player1_spd
	else:
		player_speed = GLOBALS.g_player2_spd

#called every frame 
func _fixed_process(delta):
	
	#Current Attacker is player1
	if (GLOBALS.g_current_attacker == "player1"):
		btn_right = Input.is_action_pressed("Player1_Right")
		btn_left = Input.is_action_pressed("Player1_Left")
	
	else:
		#Current Defender is player2
		btn_right = Input.is_action_pressed("Player2_Right")
		btn_left = Input.is_action_pressed("Player2_Left")
		
	
	#Attacker is not stunned
	if(!isStunned):
		
		#Player moves right
		if btn_right:
			movement(player_speed)

		#Player moves left
		if btn_left:
			movement(-player_speed)

	else:
		stunTimer-=1
		
		if(stunTimer < 0):
			isStunned = false
			stunTimer = 60

#Attacker collided with another object
func collided(dmg=0):
	hp = hp - dmg
	check_alive()
	get_node("hp_bar").set_value(hp)

#Attacker is stunned
func stunned():
	isStunned = true
	
	
#Checks Attacker's Status
func check_alive():
	if (hp <= 0):
		#kill self
		get_parent().queue_free()
		#gameover scene
		get_tree().change_scene("res://Scenes/GameOver.xml")