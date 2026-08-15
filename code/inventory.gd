## Manages items and item events.
class_name Inventory
extends Node

## Items which persist after a level is completed.
var permanent_inventory = ItemSet.new()
## Items which can be purchased during the check-out phase.
var cart_inventory = ItemSet.new()

## Adds an item to the cart inventory
func pickup(item: Item) -> void:
	item = cart_inventory.add(item)
	item.on_pickup()

## Removes an item from the cart inventory
func drop(item: Item) -> void:
	item = cart_inventory.get_item(item)
	if item == null:
		return
	item.on_drop()

## Moves an item from the cart inventory to the permanent inventory
func keep(item: Item) -> void:
	drop(item)
	item = permanent_inventory.add(item)
	item.on_pickup()
