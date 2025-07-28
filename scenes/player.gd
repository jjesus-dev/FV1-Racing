extends CharacterBody2D

@onready var SCREEN_SIZE = get_viewport_rect().size
@onready var PLAYER_SIZE = $CollisionShape2D.shape.get_rect().size

var is_death = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if is_death:
			$AnimatedSprite2D.play("hurt")
		else:
			$AnimatedSprite2D.play("jump")
	else:
		if direction:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Colisionar con las trampas o enemigos
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if (collider.name == "Tramp" or collider.name == "Enemy"):
			get_attacked(collider.name)

	# Evitar que el jugador salga de la pantalla
	if is_death == false:
		position = position.clamp(Vector2.ZERO + (PLAYER_SIZE * 2), SCREEN_SIZE - (PLAYER_SIZE * 2))

func get_attacked(_collider_name):
	is_death = true
	$CollisionShape2D.queue_free()
	print("Herido por: " + _collider_name)
