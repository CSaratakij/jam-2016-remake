
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
	set_process_input(true)
	_lblGamePause.hide()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if OS.get_name() == "Android":
			_pause_game()

func _input(event):
	if event.is_action_pressed("play"):
		_restart_game()
	elif event.is_action_pressed("pause"):
		_pause_game()

func _process(delta):
	if global.is_game_over():
		btnRestart.hide()
		btnPause.hide()
	else:
		btnRestart.show()
		btnPause.show()

func _restart_game():
	if not tree.is_paused():
		global.reset_score()
		global.game_start()
		tree.reload_current_scene()

func _pause_game():
	if not global.is_game_over():
		if not tree.is_paused():
			tree.set_pause(true)
			_lblGamePause.show()
			_animation_player.play("btnRestart_dissapear")
		else:
			tree.set_pause(false)
			_lblGamePause.hide()
			_animation_player.play("btnRestart_reapear")

func _on_btnRestart_pressed():
	_restart_game()

func _on_btnPause_pressed():
	_pause_game()

func _on_btnPause_released():
	var players = tree.get_nodes_in_group("player")
	if not players.empty():
		players[0].set_is_can_jump(not tree.is_paused())
