class_name GameManager
extends Node

static var _instance: GameManager

const player_scn = preload("res://scenes/player_controller.tscn")

@export_group("Level Generation")
@export var game_seed: String = "SEED"
@export var levels: Array[Level]
@export var level_size: int = 16

@export_group("Player")
@export var place_at: Vector2

var rng = RandomNumberGenerator.new()

var player: PlayerController

var level: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.seed = game_seed.hash()
	_instance = self
	setup_level()
	place_player()

func place_player():
	player = player_scn.instantiate() as PlayerController
	player.transform.origin = place_at
	player.add_child(Camera2D.new())
	get_tree().root.add_child.call_deferred(player)

func setup_level():
	for module in levels[level].generate(rng, level_size):
		get_tree().root.add_child.call_deferred(module)

static func get_game_manager() -> GameManager:
	return _instance
