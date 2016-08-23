
extends KinematicBody2D

const MOVE_SPEED = 280.0
const INIT_MOVE_DIRECTION = Vector2(1, 0)

onready var _movement = Vector2()
onready var _move_direction = INIT_MOVE_DIRECTION

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	_movement = _move_direction * MOVE_SPEED * delta
	move(_movement)
