extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var right_boundary = 175
var left_boundary = 25
var goleft = true
var goright = false
var moverY = 564.38269
var hp = 3
var spawn = 1

#Mover is colliding with another object
func collided(dmg = 0):
	hp -= dmg
	
	get_node("health").set_value(hp)
	
	#mover dies
	if(hp <= 0):
		
		#spawn another mover
		if(spawn != 3):
			spawn += 1
			move_to(Vector2(-50,moverY))
			hp = 3
			get_node("health").set_value(hp)
			GLOBALS.enemy_counter -= 1
		else:
			GLOBALS.enemy_counter -= 1
			get_parent().queue_free()
			
		
# starts when loaded up in scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	#mover decides to moves right
	if(get_global_pos().x < left_boundary):
		goright = true
		goleft = false
		
	#mover decided to move left
	if(get_global_pos().x > right_boundary):
		goleft = true
		goright = false
		
	
	#mover goes right
	if goright:
		move(Vector2(1,0))
	
	#mover goes left
	if goleft:
		move(Vector2(-1,0))
		
	
