
extends KinematicBody2D

const GRAVITY = 180

export var type_id = 0

var is_active = false
var velocity = Vector2()
var motion = Vector2()

var totem_sprites = [
	preload("res://totems/totem1.png"),
	preload("res://totems/totem2.png"),
	preload("res://totems/totem3.png")
	]

onready var _sprite = get_node("Sprite")
onready var _collision = get_node("CollisionShape2D")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	_collision.set_trigger(not is_active)
	if is_active:
		velocity.y += GRAVITY * delta
		motion = velocity * delta
		move(motion)

func set_active(active):
	is_active = active

func set_type(index):
	type_id = index
	_sprite.set_texture(totem_sprites[index])

func max_type():
	return totem_sprites.size()
