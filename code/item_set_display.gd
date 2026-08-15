class_name ItemSetDisplay
extends Node

const item_icon_scn = preload("res://ui/item_display.tscn")

func display_set(items: ItemSet):
	clear()
	for item in items.items:
		var item_icon = item_icon_scn.instantiate()
		item_icon.get_node("Label").text = "x%d" % item.count
		add_child(item_icon)
	
func clear():
	for item in get_children():
		item.queue_free()
