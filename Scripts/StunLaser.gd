extends Node2D

# class member variables 
var height = 650
var speed = 5
var dmg = 0
var otherCollider
var vector = Vector2(0,0);

#Stun laser checks collision with other objects
func checkCollisions():
	
	#Laser is colliding with an object
	if get_node("KinematicBody2D"):
		
		#destroy the laser
		get_node(".").queue_free()
		
		#get the other object
		otherCollider = get_node("KinematicBody2D").get_collider()
		
		#Call method from otherCollider to do an event like losing health
		otherCollider.stunned()
		

#starts when loaded up in scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_physics_process(true)

#called every frame
func _physics_process(_delta):
	
	#The laser's is moving downwards using KinematicBody2D
	var _collison = get_node("KinematicBody2D").move_and_collide(vector * speed)
	
	#The laser reached a certain position on screen
	if get_node("KinematicBody2D").global_position.y < 0:
		#this deletes the tree structure of Laser. 
		get_node(".").queue_free()
	
	#checks collisions
	checkCollisions()
	
#determine direction of laser
func setDirVector(rotate, turretVector):
	#self.set_rot(rotate)
	self.rotation = rotate
	vector = turretVector
	
