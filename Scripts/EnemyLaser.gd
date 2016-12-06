extends Node2D

# class member variables 
var height = 650
var speed = 3
var dmg = 1
var otherCollider
var vector = Vector2(0,0);

#Checks the collision with other other objects
func checkCollisions():
	
	
	#Laser is colliding with an object
	if get_node("KinematicBody2D").is_colliding():
		#destroy the laser
		get_node(".").queue_free()
		
		#get the other object
		otherCollider = get_node("KinematicBody2D").get_collider()
		
		#Call method from otherCollider to do an event like losing health
		otherCollider.collided(dmg)
		
		

#starts when loaded up in scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)

#
func _fixed_process(delta):
	
	#The laser's is moving downwards using KinematicBody2D
	get_node("KinematicBody2D").move(vector * speed)
	
	#The laser reached a certain position on screen
	if get_node("KinematicBody2D").get_global_pos().y < 0:
		#this deletes the tree structure of Laser. 
		get_node(".").queue_free()
	
		
	#check collision
	checkCollisions()

#determine what direction to set laser
func setDirVector(rotate, turretVector):
	self.set_rot(rotate)
	vector = turretVector
	
