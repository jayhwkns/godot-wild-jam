extends Area2D
class_name HurtBox
# Recives a detection/overlap from a hitbox 
# and then passes that signal to the parent where the parent handles the action

signal hurted(damage: int)

func take_damage(damage: int):
	hurted.emit(damage)
