
extends Node2D

var previous_floor = 0
var current_floor = 0

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _music_player = root.get_node("/root/music_player")
onready var players = tree.get_nodes_in_group("player")
onready var totem_spawners = get_node("Totem_Spawners").get_children()
onready var item_spanwers = get_node("Item_Spawners").get_children()

var is_init_spawn = false

func _ready():
	set_process(true)
	if not _music_player.is_playing():
		_music_player.play()
	previous_floor = players[0].get_current_floor()
	current_floor = previous_floor

func _process(delta):
	if not is_init_spawn:
		_spawn_totem()
		_spawn_item()
		is_init_spawn = true
	if not players.empty():
		current_floor = players[0].get_current_floor()
		if current_floor != previous_floor:
			if current_floor == 1:
				_spawn_totem()
				_spawn_item()
			previous_floor = current_floor
		if not players[0].get_node("health").is_alive():
			global.game_over()

func _spawn_totem():
	for spawner in totem_spawners:
		spawner.clear()
		spawner.spawn()

func _spawn_item():
	for spawner in item_spanwers:
		spawner.reset()
		spawner.spawn()
