# save and load best score.

extends Node2D

var score = 0
var best_score = 0

func _ready():
	pass

func add_score(point):
	score += point

func get_score():
	return score