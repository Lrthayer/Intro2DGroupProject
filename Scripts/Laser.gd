
extends Node2D

#class variables
var height = 650
var width = 850
var speed = GLOBALS.g_offense_spd
var dmg = GLOBALS.g_offense_dmg
var turn = 0
var otherCollider

#set damage
func set_dmg(amt):
	dmg = amt
	
#set the speed 
func set_spd(amt):
	speed = amt
	
#set the rotation
func set_turn(amt):
	amt = deg2rad(amt)
	set_rot(amt)
	turn = amt


#checks the collision of other objects
func checkCollisions():
	
	#Laser is colliding with an object
	if get_node("KinematicBody2D").is_colliding():
		#destroy the laser
		get_node(".").queue_free()
		
		#get the other object
		var otherCollider = get_node("KinematicBody2D").get_collider()
		
		#send signal to other object that it has collided
		otherCollider.collided(dmg)
		

#starts when loaded up in scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
#called every frame
func _fixed_process(delta):
	
	#The laser is moving upwards & tilted
	var vec = Vector2(0,speed).rotated(turn)
	get_node("KinematicBody2D").move(vec)
	
	
	#The laser has left the outer boundary
	var y = get_node("KinematicBody2D").get_global_pos().y
	var x = get_node("KinematicBody2D").get_global_pos().x
	if y > height ||  \
	   y < -50 ||     \
	   x > width ||   \
	   x < -50:
		#this deletes the tree structure of Laser. 
		get_node(".").queue_free()
		
	#checks collision
	checkCollisions()
	
	
	

	
	
