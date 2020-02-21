
extends Node2D

#class variables
var height = 650
var width = 850
var speed = GLOBALS.g_offense_spd
var dmg = GLOBALS.g_offense_dmg
var turn = 0
var otherCollider
var vec


#set the damage
func set_dmg(amt):
	dmg = amt

#set the speed
func set_spd(amt):
	speed = amt

#set the rotation
func set_turn(amt):
	amt = deg2rad(amt)
	#set_rot(amt)
	self.rotation = amt
	turn = amt


#check collision with other objects
func checkCollisions():
	
	#The laser's is moving downwards using KinematicBody2D
	var collisionInfo = get_node("KinematicBody2D").move_and_collide(vec * speed)
	
	if collisionInfo:
		#hide the laser
		self.global_position = Vector2(10000, 10000)
		self.get_node("KinematicBody2D").global_position = Vector2(10000, 10000)
		
		#get the other object
		otherCollider = collisionInfo.collider
		
		if self.get_node("/root/GLOBALS").state != "Editor":
			#Call method from otherCollider to do an event like losing health
			otherCollider.collided(dmg)
			
	
	#Laser is colliding with an object
	if collisionInfo:
		
		#destroy the laser
		get_node(".").queue_free()
		
		#get the other object
		var otherCollider = get_node("KinematicBody2D").get_collider()
		
		#It is colliding with Defender
		if otherCollider.get_name() == "StaticBody2D":
			if otherCollider.get_parent().get_name() == "KinematicBody2D":
				if otherCollider.get_parent().get_parent().get_name() == "Defender":
					#ignore collision
					pass
				else:
					otherCollider.collided(dmg)
			else:
				otherCollider.collided(dmg)
				
		else:
			#it is colliding with Defender
			if otherCollider.get_parent().get_name() == "Defender":
				#ignore collision
				pass
			else:
				otherCollider.collided(dmg)
			

#starts when loaded up in scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_physics_process(true)
	
#called every frame
func _physics_process(delta):
	
	#The laser is moving upwards & tilted
	vec = Vector2(0,speed).rotated(turn)
	get_node("KinematicBody2D").move_and_collide(vec)
	
	
	#The laser has left the outer boundary
	var y = get_node("KinematicBody2D").global_position.y
	var x = get_node("KinematicBody2D").global_position.x
	if y > height ||  \
	   y < -50 ||     \
	   x > width ||   \
	   x < -50:
		#this deletes the tree structure of Laser. 
		get_node(".").queue_free()
		
	#checks for collision
	checkCollisions()
	
	
	

	
	
