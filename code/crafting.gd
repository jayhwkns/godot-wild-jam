extends Node

@export var slot_a: Item = null
@export var slot_b: Item = null

@export var display: ItemFullDisplay
@export var catalog: ItemCatalog

func on_select(item: Item) -> void:
	display.display_item(item)
	if slot_a == null or (item == slot_a and item.count < 2):
		set_slot_a(item)
		return
	var product = catalog.combine(slot_a, item)
	if product == null:
		set_slot_a(item)
		return
	set_slot_b(item)
	display.display_item(product)
	display.set_mode(ItemFullDisplay.Mode.CRAFT_CONFIRM)

func set_slot_a(item: Item) -> void:
	slot_a = item
	$SlotA/TextureRect.texture = null if item == null else item.icon
	set_slot_b(null)

func set_slot_b(item: Item) -> void:
	slot_b = item
	$SlotB/TextureRect.texture = null if item == null else item.icon

func clear() -> void:
	set_slot_a(null)
	set_slot_b(null)

func _ready() -> void:
	set_slot_a(slot_a)
	set_slot_b(slot_b)
