extends Label

func _ready():
	set_process(true)

func _process(_delta):
	if (GLOBALS.g_current_attacker == "player1"):
		self.set_text("Defender's Gems: " + str(GLOBALS.g_player2_defender_score))
	else:
		self.set_text("Defender's Gems: " + str(GLOBALS.g_player1_defender_score))
