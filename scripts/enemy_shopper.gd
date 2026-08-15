extends CharacterBody2D
class_name enemy_shopper
@onready var game_manager: Node = %game_manager
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: int = 10
var health: int = 10
var health_max: int = 10
var health_min: int = 0

var direction: Vector2 = Vector2.LEFT # Always go left
const GRAVITY = 900
var knockback_force = 200
var damage_to_deal: int = 1
var damage_to_take: int = 10
var money_drop_amount: int

var is_dead: bool = false
var is_taking_damage: bool = false
var is_dealing_damage: bool = false
var is_chasing_player: bool
var is_roaming: bool = true


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.x = 0

	move(delta)
	handle_animation()
	move_and_slide()
	
func move(delta):
	if !is_dead:
		if !is_chasing_player:
			velocity += direction * speed * delta
		is_roaming = true
	elif is_dead:
		velocity.x = 0
	
func handle_animation():
	if !is_dead and !is_taking_damage and !is_dealing_damage:
		animated_sprite.play("walk")
		if direction.x == -1:
			animated_sprite.flip_h = true
		if direction.x == 1:
			animated_sprite.flip_h = false

func _on_hurtbox_hurted(damage: int) -> void:
	health -= damage
	is_taking_damage = true

	if health <= 0:
		die()

# DROP SOME MONEEEYYYY
func die():
	self.queue_free()
	
