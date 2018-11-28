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
var globalP = Vector2(0,0)

#starts when loaded up in scene
func _ready():
	set_process(true)
	laserObject = self.get_node("/root/Node2D")
	target = self.get_parent().get_node("Position2DArea2D/Position2D")
	
func _draw():
	var inv = get_global_transform().inverse()
	draw_set_transform(inv.get_origin(), inv.get_rotation(), inv.get_scale())
	#draw_set_transform (Vector2(0,0), 0, Vector2(1,1))
	draw_line(self.global_position, target.global_position, Color(255, 0, 0), 5)

#called every frame
func _process(delta):
	#globalP = self.get_node("Position2D").global_position
	theirPos = target.global_position
	myPos = self.global_position
	diff = theirPos - myPos
	rotate = atan2(diff.y,diff.x) + 3.14/2
	self.set_rotation(rotate)
	#used for draw
	update();

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