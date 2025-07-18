extends CharacterBody2D

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 100.0

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = starting_move_direction
	if direction:
		velocity.x = direction.x * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()
