class_name GameManager
extends Node

static var _instance: GameManager

@export var game_seed: String = "SEED"
@export var level: Level
@export var level_size: int = 16

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.seed = game_seed.hash()
	_instance = self
	setup_level()

func setup_level():
	for module in level.generate(rng, level_size):
		get_tree().root.add_child.call_deferred(module)

static func get_game_manager() -> GameManager:
	return _instance
