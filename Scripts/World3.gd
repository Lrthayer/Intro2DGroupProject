extends Node2D

#Class variables
var enemies = [preload("res://Scenes/EnemyShip.xml"),  \
               preload("res://Scenes/EnemyShip.xml"),  \
               preload("res://Scenes/EnemyShip2.xml")]
var enemy = null
var ticks = 0
var launch_interval = 60
var limit = 13
var count = 0

#starts when loading up in scene
func _ready():
	set_process(true)
	
#calls every frame
func _process(delta):
	launch_units(delta)
	
# pick a random type of enemy
func random_type():
	var choice = randi()%3 
	enemy = enemies[choice]

#launch units in the scene
func launch_units(t):
	if count < limit:
		ticks += 1
		if ticks >= launch_interval:
			ticks = 0
			var u = random_unit()
			u.set_owner(self)
			add_child( u )
			count += 1

#pick a random unit
func random_unit():
	random_type()
	var e = enemy.instance()
	e.random_pick()
	return e