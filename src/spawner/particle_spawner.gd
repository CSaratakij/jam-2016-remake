
extends Node2D

const MAX_PARTICLE_POOLING = 6
const MASK_TYPES = preload("res://mask/mask.gd").types
const PARTICLES = {
	"use_mask" : preload("res://particles/use_mask_particle.tscn"),
	"hit_totem" : preload("res://particles/hit_totem_particle.tscn")
}

var pooling_particles = {
	"use_mask" : [],
	"hit_totem" : []
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
				var params = {
					Particles2D.PARAM_TANGENTIAL_ACCEL : players[ 0 ].get_move_direction().x * 30
				}
				spawn("use_mask", players[ 0 ].get_global_pos(), params)
		if players[ 0 ].is_used_dig_mask:
			var params = {
				Particles2D.PARAM_TANGENTIAL_ACCEL : players[ 0 ].get_move_direction().x * 30
			}
			spawn("use_mask", players[ 0 ].get_using_mask_pos(), params)
			players[ 0 ].is_used_dig_mask = false
		if players[ 0 ].get_is_hit_totem():
			var pos = players[ 0 ].get_player_to_hit_totem_pos().normalized()
			var slope = pos.y / pos.x
			var angle_radian = atan(slope)
			var angle_degree = angle_radian * 180 / PI
			angle_degree += 180
			var params = {
				Particles2D.PARAM_DIRECTION : angle_degree
			}
			spawn("hit_totem", players[ 0 ].get_hit_totem_pos(), params)
			players[ 0 ].set_is_hit_totem(false)

func _initialize():
	var use_mask_instance = PARTICLES[ "use_mask" ].instance()
	var hit_totem_instance = PARTICLES[ "hit_totem" ].instance()
	for index in range(MAX_PARTICLE_POOLING):
		pooling_particles[ "use_mask" ].append(use_mask_instance.duplicate())
		pooling_particles[ "hit_totem" ].append(hit_totem_instance.duplicate())
		add_child(pooling_particles[ "use_mask" ][ index ])
		add_child(pooling_particles[ "hit_totem" ][ index ])

func spawn(particle_name, emit_pos, params):
	if not players.empty():
		if pooling_particles.keys().has(particle_name):
			for particle in pooling_particles[ particle_name ]:
				if not particle.is_emitting():
					for index in range(params.keys().size()):
						particle.set_param(params.keys()[ index ], params.values()[ index ])
					particle.set_global_pos(emit_pos)
					particle.set_emitting(true)
					break
