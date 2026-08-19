class_name PlayerController
extends CharacterBody2D
@onready var dash: Node2D = $Dash
@onready var hurtbox: HurtBox = $Hurtbox
@onready var hitbox: HitBox = $Hitbox

@export var stats: Stats

var direction = 0
var speed: float # handle swapping between dash and normal speed

func _ready() -> void:
	stats.setup_stats()
	stats.faction = Stats.Faction.PLAYER
	
	hurtbox.setup(stats)
	hitbox.setup(stats, 0.5)
	
func _physics_process(delta: float) -> void:
	
	if stats.current_health <= 0:
		die()
		
	if !dash.is_dashing():
		direction = get_move_direction()
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle dash.
	if Input.is_action_just_pressed("dash_attack") and dash.can_dash():
		dash.start_dash()
	
	# Check if dashing, if so then apply dashing speed and turn on hitbox and turn off hurtbox
	if dash.is_dashing():
		hitbox.monitoring = true
		hurtbox.monitorable = false
		speed = stats.current_dash_speed
	else:
		hitbox.monitoring = false
		hurtbox.monitorable = true
		speed = stats.current_speed
	
	# Handle jump if on floor and not dashing
	if Input.is_action_just_pressed("jump") and is_on_floor() and !dash.is_dashing():
		velocity.y = stats.current_jump_velocity
	
	# Get movement direction and handle horizontal speed
	if dash.is_dashing():
		velocity.x = direction * speed
		velocity.y = 0
	else:
		velocity.x = direction * speed
	
	move_and_slide()
	
func die():
	# Call game over screen here
	queue_free()
 
func get_move_direction():
	return Input.get_axis("move_left", "move_right")
	
	
