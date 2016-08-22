
extends Control

const NEXT_SCENE_PATH = "res://how_to_play/how_to_play.tscn"

func _on_btnPlay_pressed():
	get_tree().change_scene(NEXT_SCENE_PATH)