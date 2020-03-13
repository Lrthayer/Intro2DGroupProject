extends Node2D

# class member variables 
var height = 650
var speed = 5
var dmg = 0
var otherCollider
var vector = Vector2(0,0);

#starts when loaded up in scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_physics_process(true)

#called every frame
func _physics_process(_delta):
	
	#The laser's is moving downwards using KinematicBody2D
	var collision = get_node("KinematicBody2D").move_and_collide(-vector * speed)
	if collision:
		#destroy the laser
		get_node(".").queue_free()
		
		#get the other object
		otherCollider = collision.collider
		
		#Call method from otherCollider to do an event like losing health
		if otherCollider.has_method("stunned"):
			otherCollider.stunned()
		
	#The laser reached a certain position on screen
	#if get_node("KinematicBody2D").global_position.y < 0:
		#this deletes the tree structure of Laser. 
	#	get_node(".").queue_free()

#determine direction of laser
func setDirVector(rotate, turretVector):
	#self.set_rot(rotate)
	self.set_rotation(rotate)
	vector = turretVector
	
