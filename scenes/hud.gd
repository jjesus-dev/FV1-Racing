extends CanvasLayer

#signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	$LifeLabel.text = "Vidas: 0"
	show_message("Game Over")
	
	# Espera hasta que el MessageTimer ha llegado a 0
	await $MessageTimer.timeout

	# Crea un timer de un solo uso y espera a que termine
	#await get_tree().create_timer(1.0).timeout


func update_score(score):
	$ScoreLabel.text = "Puntaje: " + str(score)


func _on_message_timer_timeout() -> void:
	$Message.hide()
