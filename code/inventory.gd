## Manages items and item events.
class_name Inventory
extends Node

@onready var cart_display: Node = $Cart/GridContainer
@onready var keep_display: Node = $Keep/GridContainer

## Items which persist after a level is completed.
var keep_items = ItemSet.new()
## Items which can be purchased during the check-out phase.
var cart_items = ItemSet.new()

## Adds an item to the cart inventory
func pickup(item: Item) -> void:
	item = cart_items.add(item)
	item.on_pickup()
	cart_display.display_set(cart_items)

## Removes an item from the cart inventory.
## Returns `true` when there is an item to drop.
func drop(item: Item) -> bool:
	item = cart_items.get_item(item)
	if item == null:
		# Nothing to do.
		return false
	item.on_drop()
	if item.count == 0:
		cart_items.remove(item)
	cart_display.display_set(cart_items)
	return true

## Moves an item from the cart inventory to the keep inventory
func keep(item: Item) -> void:
	if !drop(item):
		return
	# Reset count since only 1 is being moved (not entire stack).
	item = item.duplicate()
	item.count = 0
	item = keep_items.add(item)
	item.on_pickup()
	keep_display.display_set(keep_items)
