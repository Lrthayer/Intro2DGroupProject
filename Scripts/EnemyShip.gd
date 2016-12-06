extends Node2D

#class variables
var move_speed = GLOBALS.g_enemy_spd * 20
var bullet_speed = GLOBALS.g_enemy_spd_bullet
var damage = GLOBALS.g_enemy_dmg
var bullet_data = preload("res://Scenes/Laser2.tscn")
var ticks = 0
var alarm = ceil(60 * GLOBALS.g_enemy_rate)
var pics = [preload("res://Graphics/Creeps/creep_001.tex"), \
            preload("res://Graphics/Creeps/creep_002.tex"),  \
            preload("res://Graphics/Creeps/creep_003.tex")]

#starts when loaded up in scene
func _ready():
	set_fixed_process(true)
	

#choose a sprite texture 
func random_pick():
	var howilook = get_node("PatrolPath/PathFollow2D/KinematicBody2D/EnemySprite")
	var choice = randi()%3 
	howilook.set_texture( pics[choice] )

#called every frame
func _fixed_process(delta):
	ticks = ticks + 1
	follow_path(delta)
	shoot(delta)
	
#follows a path
func follow_path(t):
	var path = get_node("PatrolPath/PathFollow2D")
	path.set_offset(path.get_offset() + (move_speed*t))
	
#EnemyShip shoots a laser
func shoot(t):
	if ticks >= alarm:
		ticks=0
		var bullet = bullet_data.instance()
		bullet.set_dmg(damage)
		bullet.set_spd(-1 * bullet_speed)
		add_child(bullet)
		bullet.set_owner(self)
		
		var pos = get_node("PatrolPath/PathFollow2D/KinematicBody2D/EnemySprite").get_global_pos()
		bullet.set_global_pos(pos + Vector2(0,-12))