extends ProgressBar

var max_health: int = 10
var heatlh: int = 10

# Called when the node enters the scene tree for the first time.
func set_health(health_value: int):
	value = health_value
