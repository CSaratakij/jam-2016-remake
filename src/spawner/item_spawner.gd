
extends Node2D

const MAX_ITEMS_PER_FLOOR = 3
const STEP = Vector2(100, 0)
const ITEMS = [
	preload("res://health/health.tscn"),
	preload("res://mask/mask.tscn")
]

var healths = []
var masks = []
var spawned_list = []

onready var start_point = get_node("start_point")
onready var end_point = get_node("end_point")

func _ready():
	var health = ITEMS[0].instance()
	var mask = ITEMS[1].instance()
	for index in range(MAX_ITEMS_PER_FLOOR):
		healths.append(health.duplicate())
		masks.append(mask.duplicate())
		add_child(healths[ index ])
		add_child(masks[ index ])
	spawn()

func spawn():
	var total_spawn = int(rand_range(0, MAX_ITEMS_PER_FLOOR + 1))
	for item in range(total_spawn):
		var random_item_id = int(rand_range(0, ITEMS.size()))
		if random_item_id == 0:
			spawned_list.append(healths[ random_item_id ])
		elif random_item_id == 1:
			var random_mask_id = int(rand_range(0, 2))
			masks[ random_item_id ].set_type(random_mask_id)
			spawned_list.append(masks[ random_item_id ])
	for item in spawned_list:
		var spawn_point = Vector2(rand_range(start_point.get_global_pos().x, end_point.get_global_pos().x), start_point.get_global_pos().y)
		item.set_global_pos(spawn_point)
		item.show()

func reset():
	for item in spawned_list:
		item.hide()
		item.set_global_pos(get_global_pos())
	spawned_list.clear()