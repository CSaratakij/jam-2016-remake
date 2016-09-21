
extends Area2D

const types = [
	"Dash",
	"Dig",
	"None"
	]

const type_textures = {
	types[0] : preload("res://mask/mask-dash.png"),
	types[1] : preload("res://mask/mask-dig.png"),
}

var type = types[ types.size() - 1 ]

onready var _sprite = get_node("Sprite")

func get_type():
	return type

func set_type(index):
	type = types[ clamp( index, 0, types.size() - 1 ) ]
	_sprite.set_texture(type_textures[ type ])
