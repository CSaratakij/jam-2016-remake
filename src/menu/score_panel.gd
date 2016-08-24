
extends Node2D

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")

func _ready():
	set_process(true)
	hide()

func _process(delta):
	if global.is_game_over():
		show()
	else:
		hide()

func _on_btnReplay_pressed():
	global.reset_score()
	global.game_start()
	tree.reload_current_scene()
