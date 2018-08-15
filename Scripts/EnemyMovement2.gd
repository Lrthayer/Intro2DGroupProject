extends KinematicBody2D


# class member variables "
var right_boundary = 775.818909 
var left_boundary = 652.818909
var goleft = true
var goright = false
var moverY = 564.38269
var hp = 3
var spawn = 1

#Mover is colliding with another object
func collided(dmg = 0):
	hp -= dmg
	
	get_node("HP").set_value(hp)
	
	#mover dies
	if(hp <= 0):
		
		#spawn another mover
		if(spawn != 3):
			spawn += 1
			move_to(Vector2(900,moverY))
			hp = 3
			get_node("HP").set_value(hp)
			GLOBALS.enemy_counter -= 1
		else:
			GLOBALS.enemy_counter -= 1
			get_parent().queue_free()
			
		
# starts when loaded up in scene
func _ready():
	set_physics_process(true)
	
func _fixed_process(delta):
	#if self.get_parent().clicked:
		#self.set_global_pos(get_global_mouse_pos())
	
	right_boundary = get_parent().get_child(1).get_child(0).global_position.x - 27
	left_boundary = get_parent().get_child(2).get_child(0).global_position.x + 27
	
	#mover decides to moves right
	if(get_global_pos().x < left_boundary):
		goright = true
		goleft = false
		
	#mover decided to move left
	if(get_global_pos().x > right_boundary):
		goleft = true
		goright = false

	#mover goes right
	if goright:
		move(Vector2(self.get_parent().speed,0))

	#mover goes left
	if goleft:
		move(Vector2(-1 * self.get_parent().speed,0))

func _on_HeightSpinBox_value_changed( value ):
	self.set_scale(Vector2(self.get_scale().x, value))

func _on_WidthSpinBox_value_changed( value ):
	self.set_scale(Vector2(value, self.get_scale().y))