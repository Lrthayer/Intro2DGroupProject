extends CollisionShape2D


func _process(_delta):
	self.global_position = get_parent().get_child(0).global_position
