extends Node2D

@export var enemy_scene : PackedScene



func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	get_tree().current_scene.add_child(enemy)
