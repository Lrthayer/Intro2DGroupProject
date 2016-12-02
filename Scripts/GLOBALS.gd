extends Node

###
### Store all the variables you want to be shared across
### scenes here.
###

# Scene tracking
var last_scene = "initial"

#currentAttacker
var g_current_attacker = ""

# Side boundaries
var g_right_boundary = 50
var g_left_boundary = 750

# Current level
var g_current_level = 0

# Current score
var g_current_score = 0

# Defender's attributes
var g_defense_spd = 3

# Attacker's attributes
var g_offense_spd = 3
var g_offense_hp = 100
var g_offense_rate = 0
var g_offense_dmg = 0
var g_offense_spd_bullet = 5

# Moving enemy attributes
var g_enemy_spd = 0
var g_enemy_hp = 0
var g_enemy_rate = 0
var g_enemy_dmg = 0

# Stationary enemy attributes
var g_turret_hp = 0
var g_turret_rate_fire = 0
var g_turret_rate_turn = 0
var g_turret_dmg = 0
