
extends Control

const NEXT_SCENE_PATH = "res://how_to_play/how_to_play.tscn"

onready var tree = get_tree()

func _on_btnPlay_pressed():
	tree.change_scene(NEXT_SCENE_PATH)
