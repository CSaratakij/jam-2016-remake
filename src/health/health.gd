
extends Node2D

const MIN_LIFE = 0
const MAX_LIFE = 3

var _current = MAX_LIFE

func get_current_life():
	return _current

func is_alive():
	return _current > MIN_LIFE

func full_restore():
	_current = MAX_LIFE

func clear():
	_current = MIN_LIFE

func restore(point):
	_current = int(clamp((_current + point), MIN_LIFE, MAX_LIFE))

func remove(point):
	_current = int(clamp((_current - point), MIN_LIFE, MAX_LIFE))
