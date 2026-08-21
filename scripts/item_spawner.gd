extends Node2D

@export var items: Array[Level]

func _on_timer_timeout() -> void:
	var item = items.pick_random()
	get_tree().root.add_child.call_deferred(item)
