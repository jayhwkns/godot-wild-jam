class_name HurtBox extends Area2D

# Recives a detection/overlap from a hitbox 
# and then passes that signal to the parent where the parent handles the action

@onready var owner_stats: Stats = owner.stats 

func _ready() -> void:
	monitoring = false # Only recieve don't detect

	# Disable default layer/mask detection
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match owner_stats.faction:
		Stats.Faction.PLAYER:
			set_collision_layer_value(3, true)
		Stats.Faction.ENEMY_SHOPPER:
			set_collision_layer_value(2, true)
			
func receive_hit(damage: int):
	owner.stats.take_damage(damage)
