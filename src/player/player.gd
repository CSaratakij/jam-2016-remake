
extends KinematicBody2D

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
var start_points = [
		Matrix32(0.0, Vector2(0, 80)),
		Matrix32(0.0, Vector2(715, 220)),
		Matrix32(0.0, Vector2(0, 360))
	]

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var _sprite = get_node("Sprite")
onready var _raycast = get_node("RayCast2D")
onready var _health = get_node("health")
onready var _sound_player = get_node("SamplePlayer")

func _ready():
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)

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
				_sound_player.play("jump")
		
		_motion = _velocity * delta
		_motion = move(_motion)
	
		if is_colliding():
			var n = get_collision_normal()
			_motion = n.slide(_motion)
			_velocity = n.slide(_velocity)
			move(_motion)

func get_current_floor():
	return current_floor

func change_move_direction_h():
	_move_direction.x *= -1

func reset_move_direction():
	_move_direction = INIT_MOVE_DIRECTION

func _on_Area2D_area_enter( area ):
	if area.get_groups().has("switch_side_trigger"):
		global.add_score(POINT)
		
		if area.get_name() == "floor1-2":
			current_floor = 2
			set_transform(start_points[current_floor - 1])
			change_move_direction_h()
			_sprite.set_flip_h(true)
		
		elif area.get_name() == "floor2-3":
			current_floor = 3
			set_transform(start_points[current_floor - 1])
			change_move_direction_h()
			_sprite.set_flip_h(false)
		
		elif area.get_name() == "floor3-1":
			current_floor = 1
			set_transform(start_points[current_floor - 1])

func _on_Area2D_body_enter( body ):
	if body.get_groups().has("totem"):
		_health.remove(1)
		_sound_player.play("hit")
		set_transform(start_points[current_floor - 1])
