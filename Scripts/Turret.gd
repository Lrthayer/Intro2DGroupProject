extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var laserObject = preload("res://Scenes/enemyLaser.tscn")
var laserCount = 0
var laserOffset = 0

var theirPos
var myPos
var target
var diff
var rotate
var timer = 1

var vector = Vector2(0,0)

func _ready():
	set_process(true)
	target = self.get_parent().get_node("Attacker/KinematicBody2D/ShipSprite")
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	theirPos = target.get_global_pos()
	myPos = self.get_global_pos()
	diff = theirPos - myPos
	rotate = atan2(-diff.y,diff.x) - 3.14/2
	self.set_rot(rotate)
	vector = (theirPos - myPos).normalized()
	
	timer = timer - delta
	if (timer <= 0):
		fire()
		timer = 5

func fire():
	print("in fire")
	laserCount += 1
	
	#create a copy of the laser object
	var laserInstance = laserObject.instance()
	
	#give the copy a name 
	laserInstance.set_name("Laser" + str(laserCount))
		
	#add a child
	get_parent().add_child(laserInstance)
	
	laserInstance.set_owner(self.get_parent())
	
	laserInstance.setDirVector(rotate, vector)
	
	#set the position of the laser copy
	laserInstance.set_global_pos(get_node("Position2D").get_global_pos())