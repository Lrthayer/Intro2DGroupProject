extends StaticBody2D

#class variables
var hp = GLOBALS.g_base_hp


#starts when loaded up in scene
func _ready():
	set_process(true)
	#indicate base is alive
	GLOBALS.base_is_dead = false
	
# Base is colliding with another object
func collided(dmg=0):
	hp = hp - dmg
	check_alive()
	GLOBALS.g_current_score += 50
	get_node("hp_bar").set_value(hp)
	
# Check Base Status
func check_alive():
	if (hp <= 0):
		GLOBALS.base_is_dead = true
		#kill self
		get_parent().queue_free()

func _on_HPSpinBox_value_changed( value ):
	hp = value
