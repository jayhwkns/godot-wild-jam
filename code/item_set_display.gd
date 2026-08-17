class_name ItemSetDisplay
extends Node

const item_icon_scn = preload("res://ui/item_display.tscn")

signal item_selected(item: Item)

func display_set(items: Array[Item], show_count = true):
	clear()
	for item in items:
		var item_icon = item_icon_scn.instantiate()
		item_icon.link_item(item)
		# If nothing will hapen when selecting an item, make item un-selectable
		if item_selected.get_connections().is_empty():
			item_icon.disabled = true
		else:
			item_icon.item_selected.connect(func(i): item_selected.emit(i))
		item_icon.show_count(show_count)
		add_child(item_icon)
	
func clear():
	for item in get_children():
		item.queue_free()
