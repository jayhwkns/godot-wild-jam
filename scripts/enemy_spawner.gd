extends Node2D
@onready var timer: Timer = $Timer
@export var enemy_scene : PackedScene



func _on_timer_timeout() -> void:
	timer.wait_time = randi_range(1, 3)
	var enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	get_tree().current_scene.add_child(enemy)
