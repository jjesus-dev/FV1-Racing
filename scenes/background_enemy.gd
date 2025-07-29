extends Area2D

signal send_enemy

var start_moving = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_moving:
		show()
		position.x += 230.0 * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Preparando enemigo...")
	start_moving = false
	hide()
	position.x = -40
	send_enemy.emit()
	#queue_free()

func activate_movement():
	start_moving = true
