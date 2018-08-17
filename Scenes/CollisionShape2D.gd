extends CollisionShape2D


func _ready():
	set_process(true)
	
func _process(delta):
	self.global_position = get_parent().get_child(0).global_position