
extends Control

const NEXT_SCENE = preload("res://menu/mainmenu.tscn")

onready var tree = get_tree()
onready var _video_player = get_node("VideoPlayer")

func _ready():
	if OS.get_name() == "Android":
			tree.set_auto_accept_quit(false)
	set_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("skip"):
		tree.change_scene(NEXT_SCENE.get_path())

func _process(delta):
	if not _video_player.is_playing():
		tree.change_scene(NEXT_SCENE.get_path())

func _on_btnSkip_pressed():
	tree.change_scene(NEXT_SCENE.get_path())
