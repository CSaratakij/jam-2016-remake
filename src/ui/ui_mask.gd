
extends HBoxContainer

const types = preload("res://mask/mask.gd").types
const type_textures = preload("res://mask/mask.gd").type_textures

var current_mask = ""
var previous_mask = ""

onready var tree = get_tree()
onready var player = tree.get_nodes_in_group("player")[0]
onready var _sprite = get_node("Sprite")

func _ready():
	set_process(true)

func _process(delta):
	if not player == null:
		current_mask = player.get_current_mask()
		if current_mask != previous_mask:
			previous_mask = current_mask
			if type_textures.has(current_mask):
				_sprite.set_texture(type_textures[ current_mask ])
