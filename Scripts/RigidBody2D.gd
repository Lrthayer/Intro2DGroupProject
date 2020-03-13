extends RigidBody2D

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

func resetPos():
	#self.global_position = startPosition.global_position
	#self.get_node("KinematicBody2D").global_position = startPosition.global_position
	self.global_position = startPosition.global_position

func setSprite(color):
	if (color == "blue"):
		#self.get_node("KinematicBody2D/Sprite").set_texture(blueProj)
		self.get_node("Sprite").set_texture(blueProj)
	elif (color == "white"):
		#self.get_node("KinematicBody2D/Sprite").set_texture(whiteProj)
		self.get_node("Sprite").set_texture(whiteProj)
func _on_ProjWidthSpinBox_value_changed( value ):
	self.set_scale(Vector2(value, self.get_scale().y))

func _on_ProjHeightSpinBox_value_changed( value ):
	self.set_scale(Vector2(self.get_scale().x, value))

func printInfo():
	pass#(self.global_position)

func _on_RigidBody2D_body_entered(_body):
		#hide the laser
		self.global_position = Vector2(10000, 10000)
		self.global_position = Vector2(10000, 10000)
