extends StaticBody2D


#Defender staticbody2D is colliding with laser
func collided(dmg = 0):
	get_parent().collided(dmg)
	
#Defender is getting stunned
func stunned():
	get_parent().stunned()
