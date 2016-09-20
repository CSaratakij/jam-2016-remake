
extends Area2D

const types = [
	"Dash",
	"Dig",
	"None"
	]

var type = types[ types.size() - 1 ]

func get_type():
	return type

func set_type(index):
	type = types[ clamp( index, 0, types.size() - 1 ) ]
