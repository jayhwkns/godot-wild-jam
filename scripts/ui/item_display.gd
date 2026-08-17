extends Node

var _item: Item = null

signal item_selected(item: Item)

func link_item(item: Item):
	_item = item
	
	self.icon = item.icon

func select():
	item_selected.emit(_item)

func show_count(show: bool) -> void:
	$Label.visible = show

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if _item == null:
		return
	$Label.text = "x%d" % _item.count
	if "time_left" in _item:
		$ProgressBar.value = _item.time_left / _item.lasts_for
		$ProgressBar.visible = _item.count > 0
