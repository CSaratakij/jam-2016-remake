
extends Node2D

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _music_player = root.get_node("/root/music_player")
onready var players = tree.get_nodes_in_group("player")

func _ready():
	set_process(true)
	if not _music_player.is_playing():
		_music_player.play()

func _process(delta):
	if not players[0].get_node("health").is_alive():
		global.game_over()
