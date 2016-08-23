
extends Control

onready var tree = get_tree()
onready var lblGamePause = get_node("lblGamePause")

func _ready():
	lblGamePause.hide()

func _on_btnRestart_pressed():
	if not tree.is_paused():
		tree.reload_current_scene()

func _on_btnPause_pressed():
	if not tree.is_paused():
		tree.set_pause(true)
		lblGamePause.show()
	else:
		tree.set_pause(false)
		lblGamePause.hide()
