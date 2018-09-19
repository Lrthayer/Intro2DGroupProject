extends Panel
var style = StyleBoxFlat.new()


func _ready():
    # The Panel doc tells you which style names there are
    #add_style_override("panel", style)
    set_process(true)

func _process(delta):
    # Some basic code animation
	var color = Color(.5, .5, .5)
	style.set_bg_color(color)
    
	# Don't forget to update so the control will redraw
	update()