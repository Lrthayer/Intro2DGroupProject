extends Node2D

# class member variables 
var redProj = preload("res://Raw Graphics/Projectiles/bullet_004.png")
var blueProj = preload("res://Raw Graphics/Projectiles/bullet_008.png")
var whiteProj = preload("res://Raw Graphics/Projectiles/bullet_white.tex")

var height = 650
var speed = 0
var dmg = 1
var otherCollider
var vector = Vector2(0,0);

var startPosition

#starts when loaded up in scene
func _ready():
	#startPosition = self.get_parent().get_node("Turret/Position2D")
	# Called every time the node is added to the scene.
	# Initialization here
	#print (self.get_parent().get_name())
	#print (self.get_parent().get_parent().get_name())
	#print (self.get_parent().get_parent().get_parent().get_name())
	#print (self.get_parent().get_parent().get_parent().get_node("Turret/Position2D").get_name())

	set_physics_process(true)

#
func _physics_process(delta):
	
	#The laser's is moving downwards using KinematicBody2D
	var collisionInfo = get_node("KinematicBody2D").move_and_collide(vector * speed)
	
	if collisionInfo:
		#hide the laser
		self.global_position = Vector2(10000, 10000)
		self.get_node("KinematicBody2D").global_position = Vector2(10000, 10000)
		
		#get the other object
		otherCollider = collisionInfo.collider
		
		if self.get_node("/root/GLOBALS").state != "Editor":
			#Call method from otherCollider to do an event like losing health
			otherCollider.collided(dmg)
	#The laser reached a certain position on screen
	#if get_node("KinematicBody2D").get_global_pos().y < 0:
		#this deletes the tree structure of Laser. 
		#get_node(".").queue_free()

func resetPos():
	#print("test")
	#print(startPosition)
	#print(startPosition.get_global_pos())
	self.global_position = startPosition.global_position
	self.get_node("KinematicBody2D").global_position = startPosition.global_position

#determine what direction to set laser
func setDirVector(rotate, turretVector):
	print(rotate)
	self.set_rotation(rotate + 3.14)
	vector = turretVector

func setSprite(color):
	if (color == "blue"):
		self.get_node("KinematicBody2D/Sprite").set_texture(blueProj)
	elif (color == "white"):
		self.get_node("KinematicBody2D/Sprite").set_texture(whiteProj)

func _on_ProjWidthSpinBox_value_changed( value ):
	self.set_scale(Vector2(value, self.get_scale().y))

func _on_ProjHeightSpinBox_value_changed( value ):
	self.set_scale(Vector2(self.get_scale().x, value))