extends CharacterBody2D
@onready var dash: Node2D = $Dash

var direction = 0
var move_speed: int = 100
var dash_speed: int = 200
var jump_velocity: int = -400.0


func _physics_process(delta: float) -> void:
	if !dash.is_dashing():
		direction = get_move_direction()
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle dash.
	if Input.is_action_just_pressed("dash_attack") and dash.can_dash():
		dash.start_dash()
	
	# Check if dashing, if so then apply dashing speed
	var speed = dash_speed if dash.is_dashing() else move_speed
	
	# Handle jump if on floor and not dashing
	if Input.is_action_just_pressed("jump") and is_on_floor() and !dash.is_dashing():
		velocity.y = jump_velocity
	
	# Get movement direction and handle horizontal speed
	if dash.is_dashing():
		velocity.x = direction * speed
		velocity.y = 0
	else:
		velocity.x = direction * speed
	
	move_and_slide()
 
func get_move_direction():
	return Input.get_axis("move_left", "move_right")
	
	
