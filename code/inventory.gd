## Manages items and item events.
class_name Inventory
extends Node

## ItemSetDisplays to display cart items. Child is added automatically.
@export var cart_displays: Array[ItemSetDisplay] = []
## ItemSetDisplays to display permanent items. Child is added automatically.
@export var keep_displays: Array[ItemSetDisplay] = []

## Which items to start with in the cart. Mostly for testing.
@export var initial_cart_items: Array[Item] = []
## Which items to start with in the permanent inventory. Mostly for testing.
@export var initial_keep_items: Array[Item] = []

## Items which persist after a level is completed.
var keep_items = ItemSet.new()
## Items which can be purchased during the check-out phase.
var cart_items = ItemSet.new()

## Adds an item to the cart inventory
func pickup(item: Item) -> void:
	item = cart_items.add(item)
	item.on_pickup()
	display_cart()

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
	display_cart()
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
	display_keep()
		
func _ready() -> void:
	cart_displays.append($Cart/ItemSetDisplay)
	keep_displays.append($Keep/ItemSetDisplay)
	for item in initial_cart_items:
		cart_items.add(item)
		item.on_pickup()
	for item in initial_keep_items:
		keep_items.add(item)
		item.on_pickup()
	display_cart()
	display_keep()

func display_cart():
	for cart_display in cart_displays:
		cart_display.display_set(cart_items)

func display_keep():
	for keep_display in keep_displays:
		keep_display.display_set(keep_items)

func _process(delta: float) -> void:
	for item in cart_items.items:
		item.process(delta)
	for item in keep_items.items:
		item.process(delta)
