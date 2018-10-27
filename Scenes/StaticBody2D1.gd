extends StaticBody2D


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	
	if self.get_parent().get_parent().inSpecial:
		self.set_collision_layer_bit(4,false)
		self.set_collision_layer_bit(5,true)
	else:
		self.set_collision_layer_bit(4,true)
		self.set_collision_layer_bit(5,false)

#Defender staticbody2D is colliding with laser
func collided(dmg = 0):
	get_parent().collided(dmg)
	
#Defender is getting stunned
func stunned():
	get_parent().stunned()

