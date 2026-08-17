## UI for Check-Out/Crafting Phase
extends Node

enum Mode {CHECK_OUT, CRAFT}

const PADDING = 10

@export var transition_speed: float = 3.0

signal crafted(item: Item)
signal purchased(item: Item)

var _mode: Mode = Mode.CHECK_OUT

var _target_x: float = 0.0

func toggle_mode():
	var shift_by = $Cart.size.x + 2 * PADDING
	var nav_text = "Keep =>"
	if _mode == Mode.CRAFT:
		_mode = Mode.CHECK_OUT
		$ItemFullDisplay.set_mode(ItemFullDisplay.Mode.PURCHASE)
	else:
		_mode = Mode.CRAFT
		shift_by *= -1
		nav_text = "<= Cart"
		$ItemFullDisplay.set_mode(ItemFullDisplay.Mode.CRAFT)
		
	$Navigator.text = nav_text
	$ItemFullDisplay.display_item(null)
	_target_x += shift_by

func deselect_empty(item: Item):
	if item.count == 0:
		$ItemFullDisplay.display_item(null)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ItemFullDisplay.purchased.connect(func(item: Item): 
		purchased.emit(item)
		deselect_empty.call_deferred(item)
	)
	$ItemFullDisplay.crafted.connect(func(item: Item):
		crafted.emit(item)
		$ItemFullDisplay.set_mode(ItemFullDisplay.Mode.CRAFT)
	)
	$ItemFullDisplay.set_mode($ItemFullDisplay.mode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.x = lerp(
		self.position.x,
		_target_x,
		delta * transition_speed
	)
