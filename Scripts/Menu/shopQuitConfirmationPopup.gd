extends ConfirmationDialog

func _on_shopQuitConfirmationPopup_confirmed():
	var _changeSceneError = get_tree().change_scene("res://Scenes/Menu/Start.tscn")
