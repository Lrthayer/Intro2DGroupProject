extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var height = 650
var speed = GLOBALS.g_offense_spd_bullet
var dmg = GLOBALS.g_offense_dmg
var otherCollider
var xVector 


func checkCollisions():

	#Laser is colliding with an object
	if get_node("KinematicBody2D").is_colliding():
		
		#get the other object
		otherCollider = get_node("KinematicBody2D").get_collider()
		
	
		#Call method from otherCollider to do an event like losing health
		otherCollider.collided()
	
		#destroy the laser
		get_node(".").queue_free()
		
		#
		#  HANDLE THIS
		#  in the "collided" function in otherCollider instead of here
		#
		# -------------------
		#destroy other object
		#otherCollider.queue_free()
		# -------------------
		#
			
			
		

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

func _fixed_process(delta):
	
	#The laser's is moving downwards using KinematicBody2D

	#get_node("KinematicBody2D").translate(Vector2(0, -speed))
	
	
	#The laser reached a certain position on screen
	if get_node("KinematicBody2D").get_global_pos().y > height:
		#this deletes the tree structure of Laser. 
		get_node(".").queue_free()

		
		
	checkCollisions()

func setDirVector(incline):
	xVector = incline
	get_node("KinematicBody2D").translate(Vector2(xVector, -speed))
	
	

	
	
