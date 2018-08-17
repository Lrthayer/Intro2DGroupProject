extends Area2D

var clicked = false
var toggled = 0

func _ready():
	connect("mouse_entered", get_node("/root/Main"), "_on_Area2D_mouse_enter")
	connect("mouse_exited", get_node("/root/Main"), "_on_Area2D_mouse_exit")
	connect("input_event", self, "_input_event")

func _input_event( viewport, event, shape_idx ):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed && toggled < 1:
				#tell Main that we are "hovering" so we don't create anything while placing this
				get_node("/root/Main").overButtonLock = true
				get_node("/root/Main").set_hovering(true)
				clicked = true
				print("true")
			elif !event.pressed:
				#tell Main that we are done hovering
				get_node("/root/Main").overButtonLock = false
				get_node("/root/Main").set_hovering(false)
				clicked = false
			toggled = toggled + 1
	else:
		toggled = 0