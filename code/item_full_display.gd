extends Node

@export var selected: Item = null

func display_item(item: Item):
	selected = item
	$TextureRect.texture = item.icon
	$Panel/ItemInfo.text = "[b]%s[/b]\n%s" % [item.display_name, item.description]	
	$Panel/Price.text = "[b][color=gold]$%d[/color][/b]" % item.price
