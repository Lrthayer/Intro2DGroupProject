
extends TextureButton

func _ready():
	set_process_input(true)
	
#Buy upgrade for attacker speed
func _pressed():
	if GLOBALS.g_current_attacker == "player1":
		if GLOBALS.g_player2_defender_score >= 1000:
			print("SPD-SHOP: " + str(GLOBALS.g_player2_spd))
			if GLOBALS.g_player2_spd <= 16:
				GLOBALS.g_player2_spd += 4
				GLOBALS.g_player2_defender_score -= 1000
				print("Upgrade Purchased!")
			else:
				print("Upgrade Maxed Out!")
		else:
			print("Not Enough Gems!")
	else:
		if GLOBALS.g_player1_defender_score >= 1000:
			if GLOBALS.g_player1_spd <= 16:
				print("SPD-SHOP 2: " + str(GLOBALS.g_player1_spd))
				GLOBALS.g_player1_spd += 4
				GLOBALS.g_player1_defender_score -= 1000
				print("Upgrade Purchased!")
			else:
				print("Upgrade Maxed Out!")
		else:
			print("Not Enough Gems!")