extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var test : CollisionShape2D = self
	test.shape.set_extents(Vector2(self.get_parent().get_node("TextureRect").rect_size/2))
