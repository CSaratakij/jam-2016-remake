
extends Node2D

const POINT = 1

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")

func _on_floor12_body_enter( body ):
	if body.get_groups()[0] == "player":
		global.add_score(POINT)

func _on_floor23_body_enter( body ):
	if body.get_groups()[0] == "player":
		global.add_score(POINT)


func _on_floor31_body_enter( body ):
	if body.get_groups()[0] == "player":
		global.add_score(POINT)
