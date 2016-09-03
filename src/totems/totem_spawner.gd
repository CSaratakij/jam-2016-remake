
extends Node2D

const MAX_OBJECT_POOLING = 6
#const MIN_STEP  = Vector2(110.8, 0)
const MIN_STEP = Vector2(120, 0)
const MAX_OFFSET = Vector2(736, 414)

export var is_invert = false

var totems = []
var is_spawn = false

onready var start_point = get_node("start_point")

func _enter_tree():
	_initialize()

func _initialize():
	var totem = preload("res://totems/totem.tscn").instance()
	for i in range(MAX_OBJECT_POOLING):
		var instance = totem.duplicate()
		instance.set_active(false)
		instance.hide()
		totems.append(instance)
		call_deferred("add_child", totems[i])

func spawn():
	var step = 0
	var total_totem = round(rand_range(1, MAX_OBJECT_POOLING))
	var offset = start_point.get_global_pos()
	var spawn_offset = offset + Vector2(step, 0.0)
	
	for i in range(total_totem):
		if is_invert:
			spawn_offset.x *= -1.0
		totems[i].set_global_pos(spawn_offset)
		totems[i].set_active(true)
		totems[i].show()
		step += MIN_STEP.x
		spawn_offset = offset + Vector2(step, 0.0)

func clear():
	for totem in totems:
		totem.set_active(false)
		totem.hide()
		totem.set_global_pos(get_global_pos())

func set_invert(is_invert):
	self.is_invert = is_invert
