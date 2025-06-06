extends Area2D

@export var speed = 400
var screen_size
var face_to = 1

func _ready():
	screen_size = get_viewport_rect().size
	
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
	
	if velocity.length() == 0:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
	elif velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
