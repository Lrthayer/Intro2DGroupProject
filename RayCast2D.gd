extends RayCast2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.cast_to = self.get_parent().get_node("Position2DArea2D/Position2D").global_position
	
	set_process(true)
	set_physics_process(true)

func _process(delta):
	pass

func _physics_process(delta):

	#if in edit mode update every frame the rotation of the turrent and casting, if in play mode it should only need to be set once in init
	#self.cast_to = self.get_parent().get_node("Position2DArea2D/Position2D").global_position
	#if self.is_colliding():
	#	print (self.get_collider())
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
