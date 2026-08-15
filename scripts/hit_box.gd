extends Area2D
class_name HitBox
# Send a detection/overlap of a hurtbox to say
# hey we're touching take X amount of damage (decided by parent node)

func _on_area_entered(area: Area2D):
	if area is HurtBox:
		area.get_damage(get_parent().damage_to_deal)
