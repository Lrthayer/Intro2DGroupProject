extends StaticBody2D

#Turret is colliding with another object
func collided(dmg = 0):
	
	#hp -= dmg
	self.get_parent().get_parent().health -= self.get_parent().get_parent().damage
	GLOBALS.g_current_score += 10
	
	#set health
	get_node("Hp").set_value(self.get_parent().get_parent().health)
	
	#destroy object when health is zero
	if (get_parent().get_parent().health <= 0):
		GLOBALS.g_current_score += 10
		GLOBALS.enemy_counter -= 1
		get_parent().queue_free()

#Starts when loaded up on scene
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
