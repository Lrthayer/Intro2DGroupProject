extends Node2D


# class member variables go here
#var laserObject = preload("res://Scenes/enemyLaser.tscn")
var laserObject
var laserCount = 0
var laserOffset = 0
var theirPos
var myPos
var target
var diff
var rotate
var timer = 1
var tick = 1
var rateIncrease = 0
var laserSpeed = 3
var laserHeight = 1
var laserWidth = 1
var vector = Vector2(0,0)

#starts when loaded up in scene
func _ready():
	set_process(true)
	laserObject = self.get_node("/root/Node2D")
	target = self.get_node("/root/Main/AttackerArea/Attacker/KinematicBody2D")
	timer = self.get_parent().fireRate

#called every frame
func _process(delta):
	theirPos = target.global_position
	myPos = self.global_position
	diff = theirPos - myPos
	rotate = atan2(diff.y,diff.x) + 3.14/2
	self.set_rotation(rotate)
	vector = (theirPos - myPos).normalized()
	self.get_parent().fireRate = self.get_parent().fireRate  - (delta + self.get_parent().fireRateDelta/100)
	#tick = tick - self.get_parent().fireRateDelta
	#enough time has passed
	if (self.get_parent().fireRate <= 0):
		fire()
		self.get_parent().fireRate = self.get_parent().fireRateStatic
		self.get_parent().fireRateDelta += self.get_parent().fireRateDelta/100

#turret shoots laser
func fire():
	laserCount += 1
	#create a copy of the laser object
	var laserInstance = self.get_node("/root/Main").getLaser()
	laserInstance.setSprite("white")
	laserInstance.set_scale(Vector2(laserWidth, laserHeight))
	laserInstance.startPosition = self.get_node("Position2D")
	#laserInstance.set_owner(self)
	laserInstance.speed = laserSpeed
	laserInstance.setDirVector(rotate, vector)
	laserInstance.resetPos()

func _on_height_value_changed( value ):
	self.set_scale(Vector2(self.get_scale().x, value))

func _on_width_value_changed( value ):
	self.set_scale(Vector2(value, self.get_scale().y))

func _on_SpeedSpinBox_value_changed( value ):
	laserSpeed = value

func _on_ProjHeightSpinBox_value_changed( value ):
	laserHeight = value

func _on_ProjWidthSpinBox_value_changed( value ):
	laserWidth = value
