# save and load best score.

extends Node2D

var score = 0
var best_score = 0
var is_game_over = false

func _ready():
	pass

func add_score(point):
	score += point

func get_score():
	return score

func reset_score():
	score = 0

func game_start():
	is_game_over = false

func game_over():
	is_game_over = true

func set_game_over(is_over):
	is_game_over = is_over