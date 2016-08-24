
extends KinematicBody2D

const GRAVITY = 1000.0
const MOVE_SPEED = 260.0
const JUMP_FORCE = 230.0
const POINT = 1
const INIT_MOVE_DIRECTION = Vector2(1, 1)

var _velocity = Vector2()
var _motion = Vector2()
var is_grounded = false
var is_jump = false
var score = 0

onready var _move_direction = INIT_MOVE_DIRECTION
onready var _sprite = get_node("Sprite")
onready var _raycast = get_node("RayCast2D")
onready var global = get_tree().get_root().get_node("/root/global")

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.type == InputEvent.SCREEN_TOUCH:
		print("touch")
		is_jump = true

func _fixed_process(delta):
	is_grounded = _raycast.is_colliding()
	
	_velocity.x = _move_direction.x * MOVE_SPEED
	_velocity.y += _move_direction.y * GRAVITY * delta
	
	if is_grounded:
		if Input.is_action_pressed("jump"):
			is_jump = true
			_velocity.y = -JUMP_FORCE
	else:
		is_jump = false
	
#	if OS.has_touchscreen_ui_hint():
#		pass
#		#Jump by touch screen
#	else:
#		pass
#		#Jump by keyboard or mouse
	
	_motion = _velocity * delta
	_motion = move(_motion)
	
	if is_colliding():
		var n = get_collision_normal()
		_motion = n.slide(_motion)
		_velocity = n.slide(_velocity)
		move(_motion)

func change_move_direction_h():
	_move_direction.x *= -1

func reset_move_direction():
	_move_direction = INIT_MOVE_DIRECTION

func _on_Area2D_area_enter( area ):
	if area.get_groups()[0] == "switch_side_trigger":
		global.add_score(POINT)
		
		if area.get_name() == "floor1-2":
			set_transform(Matrix32(0, Vector2(715, 220)))
			change_move_direction_h()
			_sprite.set_flip_h(true)
		elif area.get_name() == "floor2-3":
			set_transform(Matrix32(0, Vector2(0, 360)))
			change_move_direction_h()
			_sprite.set_flip_h(false)
		elif area.get_name() == "floor3-1":
			set_transform(Matrix32(0, Vector2(0, 80)))
