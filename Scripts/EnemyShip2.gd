extends Node2D

#class variables
var move_speed = GLOBALS.g_enemy_spd * 15
var bullet_speed = ceil(GLOBALS.g_enemy_spd_bullet / 2)
var damage = GLOBALS.g_enemy_dmg * 2
var bullet_data = preload("res://Scenes/Laser3.tscn")
var ticks = 0
var alarm = ceil(60 * GLOBALS.g_enemy_rate * 2)
var pics = [preload("res://Graphics/Ships/ship_004.tex"), \
            preload("res://Graphics/Ships/ship_005.tex")]

#starts when loaded up in scene
func _ready():
	#set 1 of three images randomly as sprite
	set_fixed_process(true)
	
#picks a random texture for sprite
func random_pick():
	var howilook = get_node("PatrolPath/PathFollow2D/KinematicBody2D/EnemySprite")
	var choice = randi()%2 # 0 or 1
	howilook.set_texture( pics[choice] )
	
#called every frame
func _fixed_process(delta):
	ticks = ticks + 1
	follow_path(delta)
	shoot(delta)

#enemyship follows a path
func follow_path(t):
	var path = get_node("PatrolPath/PathFollow2D")
	path.set_offset(path.get_offset() + (move_speed*t))

#enemyship shoots missle
func shoot(t):
	if ticks >= alarm:
		ticks=0
		var bullet = bullet_data.instance()
		bullet.set_dmg(damage)
		bullet.set_spd(-1 * bullet_speed)
		#random angle
		var ang = randi()%30+1 #between 1 and 15 degrees (incl)
		bullet.set_turn(ang-15)
		add_child(bullet)
		bullet.set_owner(self)
		
		var pos = get_node("PatrolPath/PathFollow2D/KinematicBody2D/EnemySprite").get_global_pos()
		bullet.set_global_pos(pos + Vector2(0,-12))