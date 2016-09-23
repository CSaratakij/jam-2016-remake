
extends KinematicBody2D

const mask_types = preload("res://mask/mask.gd").types
const totem_minimum_interval = preload("res://spawner/totem_spawner.gd").MIN_STEP
const GRAVITY = 980.0
const MOVE_SPEED = 240.0
const DASH_SPEED = 900.0
const JUMP_FORCE = 230.0
const POINT = 1
const INIT_MOVE_DIRECTION = Vector2(1, 1)

var score = 0
var _velocity = Vector2()
var _motion = Vector2()
var is_grounded = false
var _move_direction = INIT_MOVE_DIRECTION
var current_floor = 1
var current_mask = ""
var current_using_mask = ""
var using_mask_pos = Vector2()
var start_points = [
		Vector2(0, 80),
		Vector2(715, 220),
		Vector2(0, 360)
	]
var max_height_floors = [
		Vector2(0, 50),
		Vector2(0, 180),
		Vector2(0, 320)
	]
var is_activate_mask = false
var is_using_mask = false

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _sprite = get_node("Sprite")
onready var _raycast = get_node("RayCast2D")
onready var _health = get_node("health")
onready var _sound_players = {
	"player" : get_node("SamplePlayer/Player"),
	"item" : get_node("SamplePlayer/Item")
}
onready var _timer = get_node("Timer")

func _ready():
	if OS.get_name() == "Android":
		_timer.set_wait_time(0.18)
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		is_activate_mask = event.doubleclick
	elif event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed and not event.is_echo():
			if _timer.get_time_left() == 0:
				is_activate_mask = false
				_timer.start()
			else:
				is_activate_mask = true
				_timer.stop()
	else:
		if event.is_action_pressed("jump"):
			if _timer.get_time_left() == 0:
				is_activate_mask = false
				_timer.start()
			else:
				is_activate_mask = true
				_timer.stop()

func _process(delta):
	if global.is_game_over():
		_sprite.hide()
	else:
		_sprite.show()

func _fixed_process(delta):
	if _health.is_alive():
		if not global.is_game_over():
			if is_activate_mask:
				using_mask_pos = get_global_pos()
				current_using_mask = current_mask
				current_mask = ""
				is_using_mask = true
				is_activate_mask = false
			if is_using_mask and not current_using_mask == "":
				if current_using_mask == mask_types[ 0 ]:
					_velocity.y = 0
					_velocity.x = DASH_SPEED * _move_direction.x
					if abs(get_global_pos().distance_to(using_mask_pos)) > totem_minimum_interval * 1.5:
						stop_using_mask()
				elif current_using_mask == mask_types[ 1 ]:
					if current_floor == 3:
						change_floor(1)
					else:
						change_floor(current_floor + 1)
					set_global_pos(Vector2(get_global_pos().x, max_height_floors[ current_floor - 1].y))
					stop_using_mask()
			else:
				is_grounded = _raycast.is_colliding()
				_velocity.y += _move_direction.y * GRAVITY * delta
				_velocity.x = _move_direction.x * MOVE_SPEED
				if is_grounded:
					if Input.is_action_pressed("jump"):
						_velocity.y = -JUMP_FORCE
						_sound_players[ "player" ].play("jump")
		else:
			_velocity = Vector2(0, 0)
		
		_motion = _velocity * delta
		_motion = move(_motion)
	
		if is_colliding():
			var n = get_collision_normal()
			_motion = n.slide(_motion)
			_velocity = n.slide(_velocity)
			move(_motion)

func get_current_floor():
	return current_floor

func get_current_mask():
	return current_mask

func change_move_direction_h():
	_move_direction.x *= -1

func change_floor(next_floor):
	current_floor = next_floor
	if current_floor == 2:
		change_move_direction_h()
		_sprite.set_flip_h(true)
	elif current_floor == 3:
		change_move_direction_h()
		_sprite.set_flip_h(false)

func reset_move_direction():
	_move_direction = INIT_MOVE_DIRECTION

func stop_using_mask():
	current_using_mask = ""
	is_using_mask = false

func _on_Area2D_area_enter( area ):
	var areas = area.get_groups()
	if areas.has("switch_side_trigger"):
		global.add_score(POINT)
		stop_using_mask()
		if area.get_name() == "floor1-2":
			change_floor(2)
		elif area.get_name() == "floor2-3":
			change_floor(3)
		elif area.get_name() == "floor3-1":
			change_floor(1)
		set_global_pos(start_points[ current_floor - 1])
	elif areas.has("health"):
		_health.restore(1)
		_sound_players[ "item" ].play("item")
		area.hide()
		area.set_global_pos(area.get_parent().get_global_pos())
		
	elif areas.has("mask"):
		current_mask = area.get_type()
		_sound_players[ "item" ].play("bonus")
		area.hide()
		area.set_global_pos(area.get_parent().get_global_pos())

func _on_Area2D_body_enter( body ):
	var groups = body.get_groups()
	if groups.has("totem"):
		_health.remove(1)
		_sound_players[ "player" ].play("hit")
		set_global_pos(start_points[ current_floor - 1 ])
