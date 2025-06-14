extends RigidBody2D

func _ready() -> void:
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

# Resetear la trampa cuando comience una nueva carrera
func start(myPosition):
	position = myPosition
	show()
	$CollisionShape2D.disabled = false
