
extends Node2D

const MAX_OBJECT_POOLING = 10
const MIN_OFFSET = Vector2(0, 0)
const MIN_STEP  = Vector2(110.2, 0)
const MAX_OFFSET = Vector2(736, 414)
const SPAWN_MARGIN = Vector2(80, 0)

var totems = []
var is_spawn = false

onready var start_point = get_node("start_point")

func _enter_tree():
	_initialize()

func _ready():
	set_process(true)

func _initialize():
	var totem = preload("res://totems/totem.tscn").instance()
	for i in range(MAX_OBJECT_POOLING):
		var instance = totem.duplicate()
		instance.set_sleeping(true)
		instance.hide()
		totems.append(instance)
		call_deferred("add_child", totems[i])

func _process(delta):
	if not is_spawn:
		is_spawn = true
		spawn()
	else:
		set_process(false)

func spawn():
	var step = 0
	var offset = start_point.get_global_pos()
	for i in range(3):
		var spawn_offset = offset + Vector2(step, 0.0)
		totems[i].set_global_pos(spawn_offset)
		totems[i].set_sleeping(false)
		totems[i].show()
		step += MIN_STEP.x
