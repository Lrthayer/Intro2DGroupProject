extends TextureButton

func _ready():
	set_process_input(true)

#buy an upgrade for damage
func _pressed():
	
	if GLOBALS.g_current_attacker == "player1":
		if GLOBALS.g_player2_defender_score >= 1000:
			GLOBALS.g_player2_dmg += 1
			GLOBALS.g_player2_defender_score -= 1000
		else:
			print("Not Enough Gems!")
	else:
		if GLOBALS.g_player1_defender_score >= 1000:
			GLOBALS.g_player1_dmg += 1
			GLOBALS.g_player1_defender_score -= 1000
		else:
			print("Not Enough Gems!")
