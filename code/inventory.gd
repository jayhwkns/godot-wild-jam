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
	item_set.clean()
	return true

## Moves an item from the cart inventory to the keep inventory
func keep(item: Item) -> void:
	if !drop(item):
		return
	_keep(item)
	display_keep()
	

## Adds an item to the permanent inventory without removing it from the cart.
func _keep(item: Item) -> void:
	# Reset count since only 1 is being moved (not entire stack).
	item = item.duplicate()
	item.count = 0
	item = keep_items.add(item)
	item.on_pickup()

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

func _combine(item_a: Item, item_b: Item) -> Item:
	var product = item_a.get_product(item_b, catalog.recipes_containing(item_a))
	if product == null:
		return null
	if !_drop(item_a, keep_items):
		return null
	if !_drop(item_b, keep_items):
		return null
	return product

func craft(item: Item) -> void:
	var recipe = catalog.recipe_for(item)
	var product = _combine(recipe.ingredient_a, recipe.ingredient_b)
	if product == null:
		return
	_keep(product)

func purchase(item: Item) -> void:
	if dollars < item.price:
		return
	set_dollars(dollars - item.price)
	keep(item)

func _ready() -> void:
	cart_displays.append($Cart/ItemSetDisplay)
	keep_displays.append($Keep/ItemSetDisplay)
	dollars_displays.append($Dollars/RichTextLabel)
	for item in initial_cart_items:
		item = item.duplicate()
		cart_items.add(item)
		item.on_pickup()
	for item in initial_keep_items:
		item = item.duplicate()
		keep_items.add(item)
		item.on_pickup()
	display_cart()
	display_keep()
	set_dollars(dollars)

func _process(delta: float) -> void:
	if !process:
		return
	for item in cart_items.items:
		item.process(delta)
	for item in keep_items.items:
		item.process(delta)
