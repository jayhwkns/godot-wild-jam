extends CharacterBody2D
class_name enemy_shopper
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar

@export var stats: Stats

var direction: Vector2 = Vector2.LEFT # Always go left
const GRAVITY = 900
var knockback_force = 200
var damage_to_deal: int = 1
var money_drop_amount: int

var is_dead: bool = false
var is_taking_damage: bool = false
var is_dealing_damage: bool = false

func _ready() -> void:
	stats.current_health = stats.current_max_health
	health_bar.max_value = stats.current_max_health
	health_bar.min_value = 0
	health_bar.value = stats.current_health

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.x = 0

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

func _on_hurt_box_hurted(damage: int) -> void:
	is_taking_damage = true
	stats.current_health -= damage
	health_bar.value = damage	# assign new health value

	if stats.current_health <= 0:
		die()
	
	# NOT IMPLEMENTED YET...
	await animated_sprite.animation_finished
	is_taking_damage = false

# DROP SOME MONEEEYYYY
func die():
	is_dead = true
	self.queue_free()
	
