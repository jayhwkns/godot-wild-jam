class_name ItemFullDisplay
extends Node

enum Mode {PURCHASE, CRAFT, CRAFT_CONFIRM}

@export var mode: Mode = Mode.PURCHASE

@export var selected: Item = null

@export var catalog: ItemCatalog = null

@export var item_display_scn: Item

var _combineable: Array[Item] = []

signal purchased(item: Item)
signal crafted(item: Item)

func display_item(item: Item):
	selected = item
	if item == null:
		$TextureRect.texture = null
		$Panel/ItemInfo.text = "[b]Select Item[/b]"
		$Panel/Purchase/Price.text = ""
		$Panel/Craft/Label.text = ""
		$Panel/Purchase/Button.visible = false
		$Panel/Craft/Label/ItemSetDisplay.display_set([] as Array[Item])
		return
	$TextureRect.texture = item.icon
	$Panel/ItemInfo.text = "[b]%s[/b]\n%s" % [item.display_name, item.description]	
	$Panel/Purchase/Price.text = "[b][color=gold]$%d[/color][/b]" % item.price
	$Panel/Purchase/Button.visible = true
	_combineable = catalog.combineable_with(item)
	$Panel/Craft/Label.text = "" if _combineable.is_empty() else "Combines with"
	$Panel/Craft/Label/ItemSetDisplay.display_set(_combineable, false)

func set_mode(new_mode: Mode):
	mode = new_mode
	$Panel/Purchase.visible = false
	$Panel/Craft.visible = false
	$Panel/CraftConfirm.visible = false
	if mode == Mode.PURCHASE:
		$Panel/Purchase.visible = true
	elif mode == Mode.CRAFT && !_combineable.is_empty():
		$Panel/Craft.visible = true
	elif mode == Mode.CRAFT_CONFIRM:
		$Panel/CraftConfirm.visible = true
	display_item(selected)

func confirm():
	if mode == Mode.PURCHASE:
		purchased.emit(selected)
	elif mode == Mode.CRAFT_CONFIRM:
		crafted.emit(selected)
