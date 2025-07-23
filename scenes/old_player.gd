extends Area2D
signal hit

@export var speed = 400
var screen_size
var face_to = 1
var player_size

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	player_size = $CollisionShape2D.shape.get_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		face_to = 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		face_to = 0

	if face_to == 1:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

	if velocity.length() >= 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "idle"

	position += velocity * delta
	position = position.clamp(Vector2.ZERO + (player_size / 2), screen_size - (player_size / 2))

# Resetear al jugador cuando comience una nueva carrera
func start(myPosition):
	position = myPosition
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(_body: Node2D) -> void:
	print("contacto")
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
