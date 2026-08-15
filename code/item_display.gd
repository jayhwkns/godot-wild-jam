extends Node

var _item: Item

func link_item(item: Item):
	_item = item
	
	self.texture = item.icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Label.text = "x%d" % _item.count
	if "time_left" in _item:
		$ProgressBar.value = _item.time_left / _item.lasts_for
		$ProgressBar.visible = _item.count > 0
