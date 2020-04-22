extends Node

###
### Store all the variables you want to be shared across
### scenes here.
###

#level editor stat
var state = "Editor"

var g_current_attacker = "player2"

# Scene tracking
var last_scene = "initial"
var saved_scene = null
var saved_subscene = null
var changed_scene = false
var new_playest = false

#file editing
var current_playlist_name = "Default"
var current_level_name = "Default"
var temp_playlist = "Default"
var next_level = ""

var isSaving = false
var isLoading = false
var isPlaying = false
var PressedCancelButton = false

# Event tracking
var enemy_counter = 0
var base_is_dead = false

# Side boundaries
var g_right_boundary = 50
var g_left_boundary = 750
var g_top_boundary = 0
var g_bottom_boundary = 800

# Current level
var g_current_level = -1

# Current score
var g_current_score = 0
var g_player1_defender_score = 1000
var g_player2_defender_score = 0

# Defender's attributes
var g_defense_spd = 3

# Attacker's attributes
var g_offense_spd = 3
var g_offense_hp = 15
var g_offense_rate = 1
var g_offense_dmg = 1
var g_offense_spd_bullet = 5
var g_player1_spd = 5
var g_player2_spd = 5
var g_player1_rate = 1
var g_player2_rate = 1
var g_player1_dmg = 1
var g_player2_dmg = 1

# Moving enemy attributes
var g_enemy_spd = 4
var g_enemy_spd_bullet = 5
var g_enemy_hp = 5
var g_enemy_rate = 1
var g_enemy_dmg = 5

# Stationary enemy attributes
var g_turret_hp = 3
var g_turret_rate_fire = 0
var g_turret_rate_turn = 0
var g_turret_dmg = 3

# Enemy base attributes
var g_base_hp = 100

# Reset:
#-----------------------------------------
# resets all globals to original values
func reset():
	g_player1_defender_score = 0
	g_player2_defender_score = 0
	g_current_attacker = "player1"
	last_scene = "initial"
	saved_scene = null
	saved_subscene = null
	enemy_counter = 0
	base_is_dead = false
	g_right_boundary = 50
	g_left_boundary = 750
	g_top_boundary = 0
	g_bottom_boundary = 800
	g_current_level = -1
	g_current_score = 0
	g_defense_spd = 3
	g_offense_spd = 5
	g_player1_spd = 5
	g_player2_spd = 5
	g_offense_hp = 20
	g_offense_rate = 1
	g_player1_rate = 1
	g_player2_rate = 1
	g_player1_dmg = 1
	g_player2_dmg = 1
	g_offense_dmg = 2
	g_offense_spd_bullet = 5
	g_enemy_spd = 4
	g_enemy_spd_bullet = 5
	g_enemy_hp = 5
	g_enemy_rate = 1
	g_enemy_dmg = 5
	g_turret_hp = 3
	g_turret_rate_fire = 0
	g_turret_rate_turn = 0
	g_turret_dmg = 3
	g_base_hp = 100