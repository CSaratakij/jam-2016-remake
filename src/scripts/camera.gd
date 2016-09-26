
extends Camera2D

const MIN_POS = Vector2(361, 203)
const MAX_POS = Vector2(375, 211)

onready var tree = get_tree()
onready var players = tree.get_nodes_in_group("player")
onready var _shake_camera = get_node("shake_camera")
onready var _timer = get_node("Timer")
onready var init_shake_camera_pos = _shake_camera.get_pos()

func _ready():
	set_process(true)

func _process(delta):
	if not players.empty():
		if players[ 0 ].get_is_hit_totem():
			clear_current()
			_shake_camera.make_current()
			_timer.start()
		if _timer.get_time_left() > 0:
			_shake_camera()
		else:
			_shake_camera.clear_current()
			make_current()
			_shake_camera.set_pos(init_shake_camera_pos)

func _shake_camera():
	randomize()
	var random_pos = Vector2(rand_range(MIN_POS.x, MAX_POS.x + 1), rand_range(MIN_POS.y, MAX_POS.y + 1))
	_shake_camera.set_pos(random_pos)
