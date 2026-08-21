extends Node2D

@export var items: Array[Item]
@export var world_item_scene: PackedScene 

func _on_timer_timeout() -> void:
	if items.is_empty() or not world_item_scene:
		print("ERROR")
		return
		
	var item_resource = items.pick_random()
	
	var physical_item = world_item_scene.instantiate()
	
	physical_item.initialize(item_resource)
	
	physical_item.z_index = 1
	physical_item.global_position = global_position
	
	get_tree().root.add_child.call_deferred(physical_item)
