
extends Control

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _lblGamePause = get_node("lblGamePause")
onready var _animation_player = get_node("AnimationPlayer")
onready var btnRestart = get_node("ControlButton/btnRestart")
onready var btnPause = get_node("ControlButton/btnPause")

func _ready():
	set_process(true)
	_lblGamePause.hide()

func _process(delta):
	if global.is_game_over():
		btnRestart.hide()
		btnPause.hide()
	else:
		btnRestart.show()
		btnPause.show()

func _on_btnRestart_pressed():
	if not tree.is_paused():
		global.reset_score()
		global.game_start()
		tree.reload_current_scene()

func _on_btnPause_pressed():
	if not global.is_game_over():
		if not tree.is_paused():
			tree.set_pause(true)
			_lblGamePause.show()
			_animation_player.play("btnRestart_dissapear")
		else:
			tree.set_pause(false)
			_lblGamePause.hide()
			_animation_player.play("btnRestart_reapear")
