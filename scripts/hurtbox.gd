extends Area2D
class_name HurtBox

signal hurted(damage: int)

func get_damage(damage: int):
	hurted.emit(damage)
