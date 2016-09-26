
extends Node2D

const SAVE_PATH = "user://savegame"

var score = 0
var best_score = 0
var is_over = false
var is_loaded_save = false
var is_able_to_restart = false
var saves = {
	"score" : best_score,
}
var loaded_save = {}

onready var save_file = File.new()

func _ready():
	if not save_file.file_exists(SAVE_PATH):
		save_file.open(SAVE_PATH, save_file.WRITE)
		save_file.store_line(saves.to_json())
		save_file.close()
	set_process(true)

func _process(delta):
	if is_over:
		loaded_save = load_save(SAVE_PATH)
		best_score = loaded_save[ "score" ]
		is_loaded_save = true
		if best_score < score:
			best_score = score
			saves[ "score" ] = best_score
			save(saves, SAVE_PATH)
		is_able_to_restart = true
	else:
		is_able_to_restart = false
		is_loaded_save = false

func save(dict, path):
	if save_file.file_exists(SAVE_PATH):
		save_file.open(SAVE_PATH, save_file.WRITE)
		save_file.store_line(dict.to_json())
		save_file.close()

func load_save(path):
	if save_file.file_exists(SAVE_PATH):
		save_file.open(SAVE_PATH, save_file.READ)
		var load_file = {}
		while not save_file.eof_reached():
			load_file.parse_json(save_file.get_line())
		save_file.close()
		return load_file

func add_score(point):
	score += point

func get_score():
	return score

func get_best_score():
	return best_score

func reset_score():
	score = 0

func game_start():
	is_over = false

func game_over():
	is_over = true

func set_game_over(is_over):
	is_over = is_over

func is_game_over():
	return is_over

func is_able_to_restart():
	return is_able_to_restart

func is_loaded_save():
	return is_loaded_save