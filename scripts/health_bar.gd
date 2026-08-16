extends ProgressBar

func _ready() -> void:
	if owner.get("stats"):
		owner.stats.health_changed.connect(set_health)
		set_health(owner.stats.current_health, owner.stats.current_max_health)
	
# Called when the node enters the scene tree for the first time.
func set_health(_health_value: int, _max_health_value):
	max_value = _max_health_value
	value = _health_value
