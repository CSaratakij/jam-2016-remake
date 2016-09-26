
extends Node2D

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var lblDynamicScore = get_node("Panel/Score/lblDynamicScore")
onready var lblBestScore = get_node("Panel/BestScore/lblDynamicBestScore")

func _ready():
	set_process(true)
	hide()

func _process(delta):
	if global.is_game_over():
		var score = global.get_score()
		lblDynamicScore.set_text(str(score))
		if global.is_able_to_restart() and global.is_loaded_save():
			lblBestScore.set_text(str(global.get_best_score()))
			show()
	else:
		hide()

func _restart_game():
	global.reset_score()
	global.game_start()
	tree.reload_current_scene()

func _on_btnReplay_pressed():
	_restart_game()
