
extends Control

const NEXT_SCENE = preload("res://how_to_play/how_to_play.tscn")

onready var CREDIT_SCENE = load("res://menu/credit_menu.tscn")
onready var tree = get_tree()

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("play"):
		tree.change_scene(NEXT_SCENE.get_path())

func _on_btnPlay_pressed():
	tree.change_scene(NEXT_SCENE.get_path())

func _on_btnCredit_pressed():
	tree.change_scene(CREDIT_SCENE.get_path())
