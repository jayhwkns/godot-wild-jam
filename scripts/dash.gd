extends Node2D
@onready var duration_timer: Timer = $DurationTimer
@onready var cool_down_timer: Timer = $CoolDownTimer

var dash_duration: float = 0.2
var dash_cool_down_duration: float = 1

func start_dash():
	duration_timer.wait_time = dash_duration
	duration_timer.start()
	
func start_dash_cooldown():
	cool_down_timer.wait_time = dash_cool_down_duration
	cool_down_timer.start()

# After dash add dash cooldown
func _on_duration_timer_timeout() -> void:
	start_dash_cooldown()
	
func is_dashing():
	return !duration_timer.is_stopped()

func can_dash():
	return cool_down_timer.is_stopped()
