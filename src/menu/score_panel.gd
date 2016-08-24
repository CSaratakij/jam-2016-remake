
extends Node2D

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var lblDynamicScore = get_node("Panel/Score/lblDynamicScore")

func _ready():
	set_process(true)
	hide()

func _process(delta):
	if global.is_game_over():
		var score = global.get_score()
		lblDynamicScore.set_text(str(score))
		show()
	else:
		hide()

func _on_btnReplay_pressed():
	global.reset_score()
	global.game_start()
	tree.reload_current_scene()
