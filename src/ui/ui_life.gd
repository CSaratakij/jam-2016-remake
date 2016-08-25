
extends HBoxContainer

const RECT_HEIGHT = 20
const RECT_STEP_WIDTH = [0, 20, 40, 60]

onready var tree = get_tree()
onready var _life_sprite = get_node("Sprite")
onready var _health = tree.get_nodes_in_group("player")[0].get_node("health")

func _ready():
	set_process(true)

func _process(delta):
	_life_sprite.set_region_rect(Rect2(0.0, 0.0, RECT_STEP_WIDTH[_health.get_current_life()], RECT_HEIGHT))