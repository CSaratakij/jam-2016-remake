
extends Node2D

var previous_floor = 0
var current_floor = 0

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _music_player = root.get_node("/root/music_player")
onready var players = tree.get_nodes_in_group("player")
onready var totem_spawners = get_node("Totem_Spawners").get_children()

func _ready():
	set_process(true)
	if not _music_player.is_playing():
		_music_player.play()
	_spawn_totem()
	previous_floor = players[0].get_current_floor()
	current_floor = previous_floor

func _process(delta):
	if not players.empty():
		current_floor = players[0].get_current_floor()
		if current_floor != previous_floor:
			if current_floor == 1:
				_spawn_totem()
			previous_floor = current_floor
		if not players[0].get_node("health").is_alive():
			global.game_over()

func _spawn_totem():
	for spawner in totem_spawners:
		spawner.clear()
		spawner.spawn()
