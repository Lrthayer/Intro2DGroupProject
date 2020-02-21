
extends TextureButton

func _ready():
	set_process_input(true)

#Buy upgrade for fire rate
func _pressed():
	if GLOBALS.g_current_attacker == "player1":
		print ("player's 1 Gem before: " + str(GLOBALS.g_player2_defender_score))
		if GLOBALS.g_player2_defender_score >= 1000:
			if GLOBALS.g_player2_rate >= 0.5:
				GLOBALS.g_player2_rate -= 0.5
				GLOBALS.g_player2_defender_score -= 1000
			else:
				print("Upgrade Maxed Out!")
		else:
			print("Not Enough Gems!")
	else:
		print ("player's 2 Gem before: " + str(GLOBALS.g_player1_defender_score))
		if GLOBALS.g_player1_defender_score >= 1000:
			if GLOBALS.g_player1_rate >= 0.5:
				GLOBALS.g_player1_rate -= 0.5
				GLOBALS.g_player1_defender_score -= 1000
			else:
				print("Upgrade Maxed Out!")
		else:
			print("Not Enough Gems!")
