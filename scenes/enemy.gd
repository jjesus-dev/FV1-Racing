extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto aleatorio
	#var saltar = randi_range(1, 101)
	## Handle jump.
	#if (saltar % 43 == 1) and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Movimiento automático del enemigo
	var direction := Vector2.LEFT
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	$AnimatedSprite2D.play("push")

	move_and_slide()
	
	# Detectar colisión con jugador o trampa
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if (collider.name == "Tramp" or collider.name == "Player"):
			if collider.has_method("get_attacked"):
				collider.get_attacked("Enemy")

# Eliminar enemigo al salir de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Enemigo fuera de pantalla")
	queue_free()
