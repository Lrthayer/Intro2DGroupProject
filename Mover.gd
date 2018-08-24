extends Node2D


# class member variables 
var laserObject = preload("res://Scenes/StunLaser.tscn")
var laserCount = 0
var laserOffset = 0
var theirPos
var myPos
var target
var diff
var health = 1
var damage = 1
var speed = 1
var rotate
var timer = 5
var fireRate = 5
var rateIncrease = 0
var laserSpeed = 1
var vector = Vector2(0,0)
var toggled = 0
var clicked = false

var projectH = 1
var projectW = 1

#starts when loaded up in scene
func _ready():
	set_process(true)
	target = self.get_parent().get_parent().get_node("/root/Main/AttackerArea/Attacker/KinematicBody2D")

#called every frame
func _process(delta):
	
	#increase rate of fire of the turret over time
	rateIncrease += .00001
	theirPos = target.global_position
	myPos = self.get_node("KinematicBody2D").global_position
	diff = theirPos - myPos
	rotate = atan2(diff.y,diff.x) + 3.14/2
	vector = (theirPos - myPos).normalized()
	timer = timer - (delta + rateIncrease)
	
	#enough time has passed
	if (timer <= 0):
		fire()
		timer = fireRate

#Mover shoots stun laser
func fire():
	
	#create a copy of the laser object
	var laserInstance = self.get_node("/root/Main").getLaser()
	
	laserInstance.startPosition = self.get_node("KinematicBody2D/Position2D")
	
	#give the copy a name 
	laserInstance.set_name("Laser" + str(laserCount))
	
	laserInstance.set_scale(Vector2(projectW, projectH))
	
	laserInstance.setSprite("blue")
	#get_parent().add_child(laserInstance)
	#laserInstance.set_owner(self.get_parent())
	
	laserInstance.setDirVector(rotate, vector)
	
	laserInstance.speed = laserSpeed
	
	#set the position of the laser copy to the position2d of the mover
	laserInstance.resetPos()

func _on_HPSpinBox_value_changed( value ):
	health = value

func _on_DamageSpinBox_value_changed( value ):
	damage = value

func _on_FireRateSpinBox_value_changed( value ):
	fireRate = value

func _on_FireRateDeltaSpinBox_value_changed( value ):
	rateIncrease = value

func _on_ProjWidthSpinBox_value_changed( value ):
	projectW = value

func _on_ProjHeightSpinBox_value_changed( value ):
	projectH = value

func _on_ProjSpeedSpinBox_value_changed( value ):
	laserSpeed = value

func _on_SpeedSpinBox_value_changed( value ):
	speed = value