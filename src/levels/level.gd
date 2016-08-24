
extends Node2D

onready var tree = get_tree()
onready var root = tree.get_root()
onready var _music_player = root.get_node("/root/music_player")

func _ready():
	if not _music_player.is_playing():
		_music_player.play()