
extends Control

const NEXT_SCENE = preload("res://levels/level.tscn")

onready var tree = get_tree()

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_pressed():
		tree.change_scene(NEXT_SCENE.get_path())