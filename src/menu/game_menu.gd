
extends Control

onready var tree = get_tree()
onready var _lblGamePause = get_node("lblGamePause")
onready var _animation_player = get_node("AnimationPlayer")

func _ready():
	_lblGamePause.hide()

func _on_btnRestart_pressed():
	if not tree.is_paused():
		tree.reload_current_scene()

func _on_btnPause_pressed():
	if not tree.is_paused():
		tree.set_pause(true)
		_lblGamePause.show()
		_animation_player.play("btnRestart_dissapear")
	else:
		tree.set_pause(false)
		_lblGamePause.hide()
		_animation_player.play("btnRestart_reapear")
