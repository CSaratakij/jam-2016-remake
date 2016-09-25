
extends Node2D

const MAX_PARTICLE_POOLING = 6
const MASK_TYPES = preload("res://mask/mask.gd").types
const PARTICLES = {
	"use_mask" : preload("res://particles/use_mask.tscn")
}

var pooling_particles = {
	"use_mask" : []
}

onready var tree = get_tree()
onready var root = tree.get_root()
onready var players = tree.get_nodes_in_group("player")

func _ready():
	_initialize()
	set_process(true)

func _process(delta):
	if not players.empty():
		if players[ 0 ].get_is_using_mask():
			if players[ 0 ].get_current_using_mask() == MASK_TYPES[ 0 ]:
				spawn("use_mask", players[ 0 ].get_global_pos())
		if players[ 0 ].is_used_dig_mask:
			spawn("use_mask", players[ 0 ].get_using_mask_pos())
			players[ 0 ].is_used_dig_mask = false

func _initialize():
	var use_mask_instance = PARTICLES[ "use_mask" ].instance()
	for index in range(MAX_PARTICLE_POOLING):
		pooling_particles[ "use_mask" ].append(use_mask_instance.duplicate())
		add_child(pooling_particles[ "use_mask" ][ index ])

func spawn(particle_name, emit_pos):
	if not players.empty():
		if pooling_particles.keys().has(particle_name):
			for particle in pooling_particles[ particle_name ]:
				if not particle.is_emitting():
					particle.set_param(Particles2D.PARAM_TANGENTIAL_ACCEL, players[ 0 ].get_move_direction().x * 30)
					particle.set_global_pos(emit_pos)
					particle.set_emitting(true)
					break
