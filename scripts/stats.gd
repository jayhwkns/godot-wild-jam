class_name Stats extends Resource

enum Faction {
	PLAYER,
	ENEMY_SHOPPER
}

signal dead
signal health_changed(cur_health: int, max_health)

@export var base_max_health: int = 10
@export var base_speed: int = 10
@export var base_damage: int = 1
@export var base_jump_velocity: float = -400.0
@export var base_dash_speed: float  = 200.0
@export var faction: Faction = Faction.PLAYER

var current_max_health: int = 10
var current_speed: int = 10
var current_jump_velocity: float = -400.0
var current_dash_speed: float  = 200.0
var current_damage: int = 1

var current_health: int = 0 : set = _on_health_set

func _init() -> void:
	# Handle race condition (calls _init before editor inspect gui value)
	setup_stats.call_deferred()
	
func setup_stats() -> void:
	# recalc current stats first
	current_health = current_max_health
	current_max_health = base_max_health
	current_speed = base_speed
	current_damage = base_damage
	current_jump_velocity = base_jump_velocity
	current_dash_speed  = base_dash_speed
	
func take_damage(amount: int) -> void:
	current_health -= amount

func _on_health_set(new_value: int) -> void:
	current_health = clampi(new_value, 0, current_max_health)
	health_changed.emit(current_health, current_max_health)
	if current_health <= 0:
		dead.emit()
