
extends KinematicBody2D

#class variables
var hp = 0

#starts when loaded up in scene
func _ready():
	hp = GLOBALS.g_enemy_hp
	get_node("EnemySprite/hp_bar").set_max(hp)
	set_process(true)
	
#called every frame
func _process(delta):
	pass
	
#Enemyship is colliding with another object
func collided(dmg=0):
	hp = hp - dmg
	check_alive()
	GLOBALS.g_current_score += 10
	get_node("EnemySprite/hp_bar").set_value(hp)

#Checks Enemyship status
func check_alive():
	if (hp <= 0):
		GLOBALS.enemy_counter -= 1
		GLOBALS.g_current_score += 100
		#kill self
		get_parent().get_parent().get_parent().queue_free()
