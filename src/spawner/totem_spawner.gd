
extends Node2D

const totem = preload("res://totems/totem.tscn")
const MAX_OBJECT_POOLING = 10
const MIN_STEP = 128
const MAX_TOTEM_STACK = 2
const STACK_STEP = 20

var totems = []
var spawned_totems = []
var current_totem_stack = 1
var is_stack_able = true

onready var start_point = get_node("start_point")
onready var end_point = get_node("end_point")

func _enter_tree():
	_initialize()

func _initialize():
	var instance = totem.instance()
	for i in range(MAX_OBJECT_POOLING):
		var new_totem = instance.duplicate()
		new_totem.set_active(false)
		new_totem.hide()
		totems.append(new_totem)
		call_deferred("add_child", totems[i])

func spawn():
	var max_start_offset = start_point.get_global_pos() + Vector2(MIN_STEP / 2, 0)
	var start_offset = Vector2(rand_range(start_point.get_global_pos().x, max_start_offset.x), max_start_offset.y)
	var current_spawn_point = start_offset
	var totem_type_index = int(rand_range(0, 3))
	
	spawned_totems.append(totems[0])
	spawned_totems[0].set_type(totem_type_index)
	spawned_totems[0].set_global_pos(current_spawn_point)
	spawned_totems[0].set_active(true)
	spawned_totems[0].show()
	
	var spawned_index = 1
	
	while current_spawn_point.x + MIN_STEP < end_point.get_global_pos().x:
		
		if spawned_index < MAX_OBJECT_POOLING:
			is_stack_able = current_totem_stack < MAX_TOTEM_STACK
			totem_type_index = int(rand_range(0, 3))
			
			var is_enable_stack = int(rand_range(0, 2)) == 1
			var step_multipler = int(rand_range(1, 3))
		
			if is_stack_able and is_enable_stack:
				current_spawn_point.x += STACK_STEP
				current_totem_stack += 1
			else:
				var actual_step = MIN_STEP * step_multipler
				if (current_spawn_point.x + actual_step) < end_point.get_global_pos().x:
					current_spawn_point.x += actual_step
					current_totem_stack = 1
				else:
					break
			
			spawned_totems.append(totems[ spawned_index ])
			spawned_totems[ spawned_index ].set_type(totem_type_index)
			spawned_totems[ spawned_index ].set_global_pos(current_spawn_point)
			spawned_totems[ spawned_index ].set_active(true)
			spawned_totems[ spawned_index ].show()
			spawned_index += 1
		else:
			break

func clear():
	for totem in spawned_totems:
		totem.set_active(false)
		totem.hide()
		totem.set_global_pos(self.get_global_pos())
	spawned_totems.clear()
