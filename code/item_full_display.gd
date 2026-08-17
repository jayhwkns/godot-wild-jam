class_name ItemFullDisplay
extends Node

enum Mode {PURCHASE, CRAFT, CRAFT_CONFIRM}

@export var mode: Mode = Mode.PURCHASE

@export var selected: Item = null

signal purchased(item: Item)
signal crafted(item: Item)

func display_item(item: Item):
	selected = item
	if item == null:
		$TextureRect.texture = null
		$Panel/ItemInfo.text = "[b]Select Item[/b]"
		$Panel/Purchase/Price.text = ""
		$Panel/Craft/Label.text = ""
		return
	$TextureRect.texture = item.icon
	$Panel/ItemInfo.text = "[b]%s[/b]\n%s" % [item.display_name, item.description]	
	$Panel/Purchase/Price.text = "[b][color=gold]$%d[/color][/b]" % item.price
	$Panel/Craft/Label.text = ""

func set_mode(new_mode: Mode):
	mode = new_mode
	$Panel/Purchase.visible = false
	$Panel/Craft.visible = false
	$Panel/CraftConfirm.visible = false
	if mode == Mode.PURCHASE:
		$Panel/Purchase.visible = true
	elif mode == Mode.CRAFT:
		$Panel/Craft.visible = true
	elif mode == Mode.CRAFT_CONFIRM:
		$Panel/CraftConfirm.visible = true
		

func confirm():
	if mode == Mode.PURCHASE:
		purchased.emit(selected)
	elif mode == Mode.CRAFT_CONFIRM:
		crafted.emit(selected)
