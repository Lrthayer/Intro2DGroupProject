extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var right_boundary = 225 
var left_boundary = 25
var goleft = true
var goright = false
var moverY = 585.115417
var hp = 3
var spawn = 1

func collided():
	hp -= 1
	
	if(hp == 0):
		if(spawn != 3):
			spawn += 1
			move_to(Vector2(-50,moverY))
			hp = 3
		else:
			get_node(".").queue_free()
			
		
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	if(get_global_pos().x < left_boundary):
		goright = true
		goleft = false
		
	if(get_global_pos().x > right_boundary):
		goleft = true
		goright = false
		
	
	
	if goright:
		move(Vector2(1,0))
		
	if goleft:
		move(Vector2(-1,0))
		
	
