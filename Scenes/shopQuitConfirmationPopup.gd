extends ConfirmationDialog


func _ready():
	var _connectError = self.get_ok().connect("pressed", self, "goToStart")

func goToStart():
	var _changeSceneError = get_tree().change_scene("res://Scenes/Menu/Start.tscn")
