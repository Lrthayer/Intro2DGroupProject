extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#turret
var hp = 3

func collided():
	
	hp -= 1
	
	#destroy object when health is zero
	if (hp == 0):
		get_node(".").queue_free()
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
