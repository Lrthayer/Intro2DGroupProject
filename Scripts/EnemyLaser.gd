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
var reflected = false

func _physics_process(_delta):
	#The laser's is moving downwards using KinematicBody2D
	if !reflected:
		var collisionInfo : KinematicCollision2D = get_node("KinematicBody2D").move_and_collide(vector * speed)
		if collisionInfo:
			if collisionInfo.collider.get("reflect") and !reflected:
				reflected = true
				get_node("KinematicBody2D").move_and_collide(-vector * speed)
				#set collision as a player laser
				self.get_node("KinematicBody2D").set_collision_layer_bit(1,true)
				self.get_node("KinematicBody2D").set_collision_mask_bit(2,false)
				#self.get_node("KinematicBody2D").set_collision_mask_bit(14,true)
			else:
				#hide the laser
				self.global_position = Vector2(10000, 10000)
				self.get_node("KinematicBody2D").global_position = Vector2(10000, 10000)
				#reset collision has an laser
				self.get_node("KinematicBody2D").set_collision_mask_bit(2,true)
				self.get_node("KinematicBody2D").set_collision_mask_bit(1,false)
				
				#get the other object
				otherCollider = collisionInfo.collider
				
				
				#if self.get_node("/root/GLOBALS").state != "Editor":
					#Call method from otherCollider to do an event like losing health
				if otherCollider.has_method("collided"):
					otherCollider.collided(dmg)
	else:
		var collisionInfo = get_node("KinematicBody2D").move_and_collide(-vector * speed)
		if collisionInfo:
			print(collisionInfo.collider.get("laser"))
			if !collisionInfo.collider.get("laser"):
				self.global_position = Vector2(10000, 10000)
				self.get_node("KinematicBody2D").global_position = Vector2(10000, 10000)

func resetPos():
	self.global_position = startPosition.global_position
	self.get_node("KinematicBody2D").global_position = startPosition.global_position
	reflected = false
	self.get_node("KinematicBody2D").set_collision_mask_bit(2,true)
	self.get_node("KinematicBody2D").set_collision_mask_bit(14,false)

#determine what direction to set laser
func setDirVector(rotate, turretVector):
	self.set_rotation(rotate)
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
