
extends Control

const NEXT_SCENE_PATH = "res://menu/mainmenu.tscn"

var is_force_skip = false

onready var tree = get_tree()
onready var _timer = get_node("Timer")
onready var _video_player = get_node("VideoPlayer")

func _ready():
	set_process(true)

func _process(delta):
	if is_force_skip:
		tree.change_scene(NEXT_SCENE_PATH)
	else:
		if not _video_player.is_playing():
			if _timer.get_time_left() == 0.0:
				_timer.start()

func _on_btnSkip_pressed():
	is_force_skip = true

func _on_Timer_timeout():
	tree.change_scene(NEXT_SCENE_PATH)
