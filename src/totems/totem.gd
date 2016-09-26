
extends KinematicBody2D

var type_id = 0
var is_active = false

var totem_textures = [
	preload("res://totems/totem1.png"),
	preload("res://totems/totem2.png"),
	preload("res://totems/totem3.png")
]

onready var _sprite = get_node("Sprite")

func _ready():
	set_type(type_id)

func set_active(active):
	is_active = active

func set_type(index):
	type_id = index
	_sprite.set_texture(totem_textures[ index ])

func max_type():
	return totem_textures.size()
