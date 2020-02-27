extends Node2D

# class member variables 
var laserObject = preload("res://Scenes/StunLaser.tscn")
var laserCount = 0
var laserOffset = 0
var theirPos
var myPos
var target
var diff
var rotate
var timer = 5
var rateIncrease = 0
var vector = Vector2(0,0)
var speed = 1

#starts when loaded up in scene
func _ready():
	set_process(true)
	target = self.get_parent().get_node("Attacker/KinematicBody2D/ShipSprite")

#called every frame
func _process(delta):
	#increase rate of fire of the turret over time
	rateIncrease += .00001
	#theirPos = target.get_global_pos()
	theirPos = global_position
	#myPos = self.get_global_pos()
	myPos = self.global_position
	diff = theirPos - myPos
	rotate = atan2(-diff.y,diff.x) - 3.14/2
	vector = (theirPos - myPos).normalized()
	timer = timer - (delta + rateIncrease)
	
	#enough time has passed
	if (timer <= 0):
		fire()
		timer = 5

#Mover shoots stun laser
func fire():
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
	#laserInstance.set_global_pos(get_node("KinematicBody2D/Position2D").get_global_pos())
	laserInstance.global_position = get_node("KinematicBody2D/Position2D").global_position
