
extends HBoxContainer

const RECT_WIDTH = 20
const RECT_HEIGHT = 20

var rects_life = [
		Rect2(0, 0, RECT_WIDTH * 0, RECT_HEIGHT),
		Rect2(0, 0, RECT_WIDTH * 1, RECT_HEIGHT),
		Rect2(0, 0, RECT_WIDTH * 2, RECT_HEIGHT),
		Rect2(0, 0, RECT_WIDTH * 3, RECT_HEIGHT)
	]

var current_life = 0
var current_rect_life = 0

onready var tree = get_tree()
onready var _life_sprite = get_node("Sprite")
onready var _health = tree.get_nodes_in_group("player")[0].get_node("health")

func _ready():
	set_process(true)

func _process(delta):
	current_life = _health.get_current_life()
	current_rect_life = rects_life[current_life]
	_life_sprite.set_region_rect(current_rect_life)
