extends CharacterBody2D

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 100.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Movimiento automático de la trampa
	var direction : Vector2 = starting_move_direction
	if direction:
		velocity.x = direction.x * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()

	# Detectar colisión con jugador
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if (collider.name == "Player"):
			if collider.has_method("get_attacked"):
				collider.get_attacked("Tramp")

# Eliminar trampa al colisionar con el enemigo
func get_attacked(_collider_name):
	$CollisionShape2D.queue_free()

# Eliminar la trampa al salir de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Trampa fuera de pantalla")
	queue_free()
