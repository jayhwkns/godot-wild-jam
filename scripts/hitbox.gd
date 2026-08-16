class_name HitBox extends Area2D

# Send a detection/overlap of a hurtbox to say
# hey we're touching take X amount of damage (decided by parent node)

var attacker_stats: Stats
var hitbox_lifetime: float # TO-DO: Use for player cart charge

func setup(_attacker_stats: Stats, _hitbox_lifetime: float) -> void:
	attacker_stats = _attacker_stats
	hitbox_lifetime = _hitbox_lifetime

	monitorable = false # Only detect don't recieve
	area_entered.connect(_on_area_entered)

	# Disable default layer/mask detection
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match attacker_stats.faction:
		Stats.Faction.PLAYER:
			set_collision_mask_value(3, true)
		Stats.Faction.ENEMY_SHOPPER:
			set_collision_mask_value(2, true)

func _on_area_entered(area: Area2D):
	if area.has_method("receive_hit"):
		area.receive_hit(attacker_stats.current_damage)
