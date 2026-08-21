class_name Stats extends Resource

enum Faction {
	PLAYER,
	ENEMY_SHOPPER,
	CROWD
}

enum BuffableStats {
	MAX_HEALTH,
	HEALTH,
	SPEED,
	JUMP_VELOCITY,
	DASH_SPEED,
	DAMAGE
}

signal dead
signal health_changed(cur_health: int, max_health)

@export var base_max_health: int = 10
@export var base_speed: float = 10.0
@export var base_damage: int = 1
@export var base_jump_velocity: float = -400.0
@export var base_dash_speed: float  = 200.0
@export var faction: Faction = Faction.PLAYER

var current_max_health: int = 10
var current_speed: float = 10.0
var current_jump_velocity: float = -400.0
var current_dash_speed: float  = 200.0
var current_damage: int = 1

var current_health: int = 0 : set = _on_health_set

var stat_buffs: Array[StatBuff]

func _init() -> void:
	# Handle race condition (calls _init before editor inspect gui value)
	setup_stats.call_deferred()
	
func setup_stats() -> void:
	# recalc current stats first
	current_speed = base_speed
	# CROWD doesn't need these
	if !faction == Stats.Faction.CROWD:
		current_health = current_max_health
		current_max_health = base_max_health
		current_damage = base_damage
		current_jump_velocity = base_jump_velocity
		current_dash_speed  = base_dash_speed
		
func add_buff(buff: StatBuff) -> void:
	stat_buffs.append(buff)
	recalculate_stats.call_deferred()
	
func remove_buff(buff: StatBuff) -> void:
	stat_buffs.erase(buff)
	recalculate_stats.call_deferred()
	
func recalculate_stats() -> void:
	var stat_multipliers: Dictionary = {} # Amount to multiply stats by
	var stat_addends: Dictionary = {} # Amount to add to stats
	for buff in stat_buffs:
		var stat_name: String = BuffableStats.keys()[buff.stat].to_lower()
		match buff.buff_type:
			StatBuff.BuffType.MULTIPLY:
				if not stat_multipliers.has(stat_name):
					stat_multipliers[stat_name] = 1
				stat_multipliers[stat_name] *= buff.buff_amount
			StatBuff.BuffType.ADD:
				if not stat_addends.has(stat_name):
					stat_addends[stat_name] = 0
				stat_addends[stat_name] *= buff.buff_amount
	
	for stat_name in stat_multipliers:
		var cur_property_name: String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) * stat_multipliers[stat_name])
		
	for stat_name in stat_addends:
		var cur_property_name: String = str("current_" + stat_name)
		set(cur_property_name, get(cur_property_name) + stat_addends[stat_name])
	
func take_damage(amount: int) -> void:
	current_health -= amount

func _on_health_set(new_value: int) -> void:
	current_health = clampi(new_value, 0, current_max_health)
	health_changed.emit(current_health, current_max_health)
	if current_health <= 0:
		dead.emit()
