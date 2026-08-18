class_name cowd extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var hitbox: HitBox = $Hitbox
@onready var hurtbox: HurtBox = $hurtbox

@export var stats: Stats
var direction: Vector2 = Vector2.RIGHT # Always go right
const GRAVITY = 900
var knockback_force = 200

func _ready() -> void:
	stats.setup_stats()
	stats.faction = Stats.Faction.ENEMY_SHOPPER


func _physics_process(delta):
	position += Vector2(GRAVITY * delta, 0).normalized()

	move(delta)
	handle_animation()
	
func move(delta):
	position += direction * stats.current_speed * delta
	
# Waiting on art
func handle_animation():
	pass

# Insta kill EVERYTHING
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("die"):
		area.die()
