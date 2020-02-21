extends Button

func _ready():
	set_process_input(true)

func _pressed():
	self.get_node("shopQuitConfirmationPopup").popup_centered()