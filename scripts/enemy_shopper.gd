extends CharacterBody2D
class_name enemy_shopper
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var hitbox: HitBox = $Hitbox
@onready var hurtbox: HurtBox = $hurtbox

@export var stats: Stats
@export var skins: Array[Texture]
var direction: Vector2 = Vector2.LEFT # Always go left
const GRAVITY = 900
var knockback_force = 200
var damage_to_deal: int = 1
var money_drop_amount: int

var is_dead: bool = false
var is_taking_damage: bool = false
var is_dealing_damage: bool = false

func _ready() -> void:
	# Don't share same stats
	stats = stats.duplicate(true)
	stats.setup_stats()
	stats.faction = Stats.Faction.ENEMY_SHOPPER
	
	hurtbox.setup(stats)
	hitbox.setup(stats, 0.5)
	z_index = 1
	$Sprite2D.texture = skins[randi() % skins.size()]

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.x = 0
	
	if stats.current_health <= 0:
		die()
		
	move(delta)
	handle_animation()
	move_and_slide()
	
func move(delta):
	if is_dead:
		velocity.x = 0
	else:
		velocity += direction * stats.current_speed * delta
	
	
func handle_animation():
	if !is_dead and !is_taking_damage and !is_dealing_damage:
		if direction.x == -1:
			animated_sprite.flip_h = true
		if direction.x == 1:
			animated_sprite.flip_h = false

# DROP SOME MONEEEYYYY
func die():
	self.queue_free()
