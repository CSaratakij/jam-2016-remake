
extends HBoxContainer

onready var tree = get_tree()
onready var root = tree.get_root()
onready var global = root.get_node("/root/global")
onready var lblDynamicScore = get_node("lblDynamicScore")

func _ready():
	set_process(true)

func _process(delta):
	var current_score = str(global.get_score())
	lblDynamicScore.set_text(current_score)