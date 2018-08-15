extends KinematicBody2D

# class member variables
var btn_right = false
var btn_left = false
var btn_up = false
var btn_down = false
var current_speed = Vector2(0,0)
var player_speed
var left_boundary
var right_boundary
var top_boundary
var bottom_boundary
#var top_boundary = GLOBALS.g_top_boundary
#var down_boundary = GLOBALS.g_bottom_boundary
var hp = GLOBALS.g_offense_hp
var shipPositionY
var isStunned = false
var stunTimer = 60


#Gives movement to Attacker
func movement(speedX, speedY):
	
	current_speed.x = speedX
	current_speed.y = speedY
	#check right side boundary for Attacker
	if get_global_transform().x > right_boundary:
		set_global_pos(Vector2(right_boundary,self.get_global_transform().y))

	#check left side boundary for Attacker
	if get_global_transform().x < left_boundary:
		set_global_pos(Vector2(left_boundary,self.get_global_transform().y))
	
	if get_global_transform().y > bottom_boundary:
		set_global_pos(Vector2(self.get_global_transform().x, bottom_boundary))
		
	if get_global_transform().y < top_boundary:
		set_global_pos(Vector2(self.get_global_transform().x, top_boundary))
	#move the Attacker
	move(current_speed)

#Starts when scene is loaded 
func _ready():
	
	get_node("hp_bar").set_max(hp)
	shipPositionY = self.get_global_transform().y
	_fixed_process(true)

	if (GLOBALS.g_current_attacker == "player1"):
		player_speed = GLOBALS.g_player1_spd
	else:
		player_speed = GLOBALS.g_player2_spd

#called every frame 
func _fixed_process(delta):
	
	right_boundary = get_parent().get_child(3).get_child(0).get_global_transform().x.x - 36
	left_boundary = get_parent().get_child(4).get_child(0).get_global_transform().x.x + 36
	top_boundary = get_parent().get_child(1).get_child(0).get_global_transform().y.y + 30
	bottom_boundary = get_parent().get_child(2).get_child(0).get_global_transform().y.y - 30
	
	#Current Attacker is player1
	if (GLOBALS.g_current_attacker == "player1"):
		btn_right = Input.is_action_pressed("Player1_Right")
		btn_left = Input.is_action_pressed("Player1_Left")
		btn_up = Input.is_action_pressed("Player1_Up")
		btn_down = Input.is_action_pressed("Player1_Down")
	
	else:
		#Current Defender is player2
		btn_right = Input.is_action_pressed("Player2_Right")
		btn_left = Input.is_action_pressed("Player2_Left")
		btn_up = Input.is_action_pressed("Player2_Up")
		btn_down = Input.is_action_pressed("Player2_Down")
		
	#Attacker is not stunned
	if(!isStunned):
		
		#Player moves right
		if btn_right:
			movement(player_speed, 0)

		#Player moves left
		if btn_left:
			movement(-player_speed, 0)
		
		if btn_up:
			movement(0, -player_speed)
		
		if btn_down:
			movement(0, player_speed)

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

func _on_SpeedSpinBox_value_changed( value ):
	player_speed = value

func _on_HeightSpinBox_value_changed( value ):
	self.set_scale(Vector2(self.get_scale().x, value))

func _on_WidthSpinBox_value_changed( value ):
	self.set_scale(Vector2(value, self.get_scale().y))

func _on_HPSpinBox_value_changed( value ):
	hp = value