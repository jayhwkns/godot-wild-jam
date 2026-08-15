class_name TempItem
extends Item

@export var lasts_for: float = 30
var time_left: float = lasts_for

func process(delta: float) -> void:
	if count <= 0:
		return
	time_left = clamp(time_left - delta, 0, lasts_for)
	if time_left <= 0:
		on_drop()
		print(count)
		time_left = lasts_for
