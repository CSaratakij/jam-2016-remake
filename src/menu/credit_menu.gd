
extends Control

onready var NEXT_SCENE_PATH = load("res://menu/mainmenu.tscn")
onready var tree = get_tree()

func _on_btnBack_pressed():
	tree.change_scene(NEXT_SCENE_PATH.get_path())
