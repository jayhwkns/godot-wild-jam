extends Node

var rng = RandomNumberGenerator.new()
@export var game_seed: String = "SEED"

@export var level_node: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.seed = game_seed.hash()
	spawn_node()

func spawn_node() -> void:
	var instance = level_node.instantiate()
	add_child(instance)
