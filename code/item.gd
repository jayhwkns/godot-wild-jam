# Template for an item and its required methods.
class_name Item
extends Resource

@export var id: String = "PLACEHOLDER_ITEM"

@export var display_name: String = "Placeholder Item"

@export_multiline var description: String = (
	"This item doesn't do anything. It was never meant to."
)

@export var icon: Texture2D = preload("res://art/placeholder/PLACEHOLDER_ITEM.bmp")

var count: int = 0

func on_pickup() -> void:
	count += 1

func on_drop() -> void:
	count -= 1

## Called every frame when in inventory.
func process(_delta: float) -> void:
	pass
