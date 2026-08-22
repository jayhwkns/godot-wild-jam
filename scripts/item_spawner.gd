extends Node2D
@onready var timer: Timer = $Timer

@export var items: Array[Item]
@export var world_item_scene: PackedScene 

func _on_timer_timeout() -> void:
	timer.wait_time = randi_range(1, 6)
	if items.is_empty() or not world_item_scene:
		print("Item spawner error")
		return

	var item_resource = items.pick_random()
	
	var physical_item = world_item_scene.instantiate()
	
	physical_item.initialize(item_resource)
	
	physical_item.z_index = 1
	physical_item.global_position = global_position
	
	get_tree().root.add_child.call_deferred(physical_item)
