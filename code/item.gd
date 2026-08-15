# Template for an item and its required methods.
class_name Item
extends Resource

@export var id: String = "PLACEHOLDER_ITEM"

@export var display_name: String = "Placeholder Item"

@export_multiline var description: String = (
	"This item doesn't do anything. It was never meant to."
)

@export var icon: ImageTexture

var _count: int = 0

func on_pickup() -> void:
	_count += 1

func on_drop() -> void:
	_count -= 1

func count() -> int:
	return _count
