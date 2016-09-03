
extends KinematicBody2D

const GRAVITY = 100.0

var is_active = false
var velocity = Vector2()
var motion = Vector2()

onready var _collision = get_node("CollisionShape2D")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	_collision.set_trigger(not is_active)
	if is_active:
		velocity.y += GRAVITY * delta
		motion = velocity * delta
		move(motion)

func set_active(is_active):
	self.is_active = is_active