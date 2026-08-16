class_name HitBox extends Area2D

# Send a detection/overlap of a hurtbox to say
# hey we're touching take X amount of damage (decided by parent node)

var attacker_stats: Stats
var hitbox_lifetime: float # TO-DO: Use for player cart charge
var shape: Shape2D
# TO-DO: add hitbox logging

func _init(_attacker_stats: Stats, _hitbox_lifetime: float, _shape: Shape2D) -> void:
	attacker_stats = _attacker_stats
	hitbox_lifetime = _hitbox_lifetime
	shape = _shape

func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
	
	if shape:
		var collision_shape = CollisionObject2D
		collision_shape.shape = shape
		add_child(collision_shape)
		
	# Disable default layer/mask detection
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match attacker_stats.faction:
		Stats.Faction.PLAYER:
			set_collision_mask_value(3, true)
		Stats.Faction.ENEMY_SHOPPER:
			set_collision_mask_value(2, true)

func _on_area_entered(area: Area2D):
	if area is HurtBox:
		area.get_damage(attacker_stats.current_damage)
