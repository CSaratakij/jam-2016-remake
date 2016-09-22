
extends KinematicBody2D

const mask_types = preload("res://mask/mask.gd").types
const GRAVITY = 980.0
const MOVE_SPEED = 240.0
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
var start_points = [
		Matrix32(0.0, Vector2(0, 80)),
		Matrix32(0.0, Vector2(715, 220)),
		Matrix32(0.0, Vector2(0, 360))
	]
var is_activate_mask = false
var total_released_jump = 0

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _sprite = get_node("Sprite")
onready var _raycast = get_node("RayCast2D")
onready var _health = get_node("health")
onready var _sound_player = {
	"player" : get_node("SamplePlayer/Player"),
	"item" : get_node("SamplePlayer/Item")
}
onready var _timer = get_node("Timer")

func _ready():
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		is_activate_mask = event.doubleclick
	else:
		if event.is_action_pressed("jump"):
			if _timer.get_time_left() == 0:
				_timer.start()
		if event.is_action_released("jump"):
			total_released_jump += 1
			if total_released_jump == 2:
				is_activate_mask = _timer.get_time_left() != 0
				_timer.stop()
				total_released_jump = 0

func _process(delta):
	if global.is_game_over():
		_sprite.hide()
	else:
		_sprite.show()

func _fixed_process(delta):
	if _health.is_alive():
		is_grounded = _raycast.is_colliding()
		_velocity.y += _move_direction.y * GRAVITY * delta
	
		if not global.is_game_over():
			_velocity.x = _move_direction.x * MOVE_SPEED
		else:
			_velocity.x = 0.0
		
		if is_grounded:
			if Input.is_action_pressed("jump"):
				_velocity.y = -JUMP_FORCE
				_sound_player[ "player" ].play("jump")
		
		if is_activate_mask:
			if current_mask == mask_types[0]:
				_velocity.y = 0.0
				_velocity.x += 600 * _move_direction.x
				pass
			elif current_mask == mask_types[1]:
				pass
			current_mask = ""
			is_activate_mask = false
		
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

func reset_move_direction():
	_move_direction = INIT_MOVE_DIRECTION

func _on_Area2D_area_enter( area ):
	var areas = area.get_groups()
	if areas.has("switch_side_trigger"):
		global.add_score(POINT)
		if area.get_name() == "floor1-2":
			current_floor = 2
			change_move_direction_h()
			_sprite.set_flip_h(true)
		elif area.get_name() == "floor2-3":
			current_floor = 3
			change_move_direction_h()
			_sprite.set_flip_h(false)
		elif area.get_name() == "floor3-1":
			current_floor = 1
		set_transform(start_points[current_floor - 1])
	elif areas.has("health"):
		_health.restore(1)
		_sound_player[ "item" ].play("item")
		area.hide()
		area.set_global_pos(area.get_parent().get_global_pos())
		
	elif areas.has("mask"):
		current_mask = area.get_type()
		_sound_player[ "item" ].play("bonus")
		area.hide()
		area.set_global_pos(area.get_parent().get_global_pos())

func _on_Area2D_body_enter( body ):
	var groups = body.get_groups()
	if groups.has("totem"):
		_health.remove(1)
		_sound_player[ "player" ].play("hit")
		set_transform(start_points[current_floor - 1])
