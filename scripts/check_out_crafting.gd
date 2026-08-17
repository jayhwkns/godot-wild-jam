## UI for Check-Out/Crafting Phase
extends Node

enum Mode {CHECK_OUT, CRAFT}

const PADDING = 10

@export var transition_speed: float = 3.0

var _mode: Mode = Mode.CHECK_OUT

var _target_x: float = 0.0

func toggle_mode():
	var shift_by = $Cart.size.x + 2 * PADDING
	var nav_text = "Keep =>"
	if _mode == Mode.CRAFT:
		_mode = Mode.CHECK_OUT
	else:
		_mode = Mode.CRAFT
		shift_by *= -1
		nav_text = "<= Cart"
	$Navigator.text = nav_text
	_target_x += shift_by

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.x = lerp(
		self.position.x,
		_target_x,
		delta * transition_speed
	)
