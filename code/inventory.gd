## Manages items and item events.
class_name Inventory
extends Node

## Whether `process` should be run for items.
@export var process = true

## ItemSetDisplays to display cart items. Child is added automatically.
@export var cart_displays: Array[ItemSetDisplay] = []
## ItemSetDisplays to display permanent items. Child is added automatically.
@export var keep_displays: Array[ItemSetDisplay] = []
## Displays the amount of money.
@export var dollars_displays: Array[RichTextLabel] = []

## Which items to start with in the cart. Mostly for testing.
@export var initial_cart_items: Array[Item] = []
## Which items to start with in the permanent inventory. Mostly for testing.
@export var initial_keep_items: Array[Item] = []

## Items which persist after a level is completed.
var keep_items = ItemSet.new()
## Items which can be purchased during the check-out phase.
var cart_items = ItemSet.new()

@export var dollars: int = 0

@export var catalog: ItemCatalog

## Adds an item to the cart inventory
func pickup(item: Item) -> void:
	item = item.duplicate()
	item = cart_items.add(item)
	item.on_pickup()
	display_cart()

## Removes an item from the cart inventory.
## Returns `true` when there is an item to drop.
func drop(item: Item) -> bool:
	if !_drop(item, cart_items):
		return false
	display_cart()
	return true

func _drop(item: Item, item_set: ItemSet) -> bool:
	item = item_set.get_item(item)
	if item == null:
		# Nothing to do.
		return false
	item.on_drop()
	if item.count == 0:
		item_set.remove(item)
	return true

## Moves an item from the cart inventory to the keep inventory
func keep(item: Item) -> void:
	if !drop(item):
		return
	_keep(item)
	display_keep()
	

func _keep(item: Item) -> void:
	# Reset count since only 1 is being moved (not entire stack).
	item = item.duplicate()
	item.count = 0
	item = keep_items.add(item)
	item.on_pickup()

func _ready() -> void:
	cart_displays.append($Cart/ItemSetDisplay)
	keep_displays.append($Keep/ItemSetDisplay)
	dollars_displays.append($Dollars/RichTextLabel)
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
		cart_display.display_set(cart_items.items)

func display_keep():
	for keep_display in keep_displays:
		keep_display.display_set(keep_items.items)

func set_dollars(new_dollars: int):
	dollars = new_dollars
	for dollars_display in dollars_displays:
		dollars_display.text = "[b][color=gold]$%d[/color][/b]" % dollars

func combine(item_a: Item, item_b: Item) -> void:
	var product = item_a.get_product(item_b, catalog.recipes_containing(item_a))
	if product == null:
		return
	if !_drop(item_a, keep_items):
		return
	if !_drop(item_b, keep_items):
		return
	_keep(product)

func _process(delta: float) -> void:
	if !process:
		return
	for item in cart_items.items:
		item.process(delta)
	for item in keep_items.items:
		item.process(delta)
