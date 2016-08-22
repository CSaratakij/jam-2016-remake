
extends Control

onready var tree = get_tree()

func _on_btnRestart_pressed():
	if not tree.is_paused():
		tree.reload_current_scene()

func _on_btnPause_pressed():
	tree.set_pause(not tree.is_paused())
