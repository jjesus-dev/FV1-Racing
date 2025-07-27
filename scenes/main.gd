extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
	$ScoreTimer.stop()
	#$Player.hide()
	$HUD.show_game_over()

func spawn_tramp():
	var new_tramp = preload("res://scenes/tramp.tscn").instantiate()
	%PathFollow2D.progress_ratio = 0.3
	new_tramp.global_position = %PathFollow2D.global_position
	add_child(new_tramp)

func new_game() -> void:
	score = 0
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("¡Preparate!")

func _ready() -> void:
	new_game()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$TrampTimer.start()


func _on_tramp_timer_timeout() -> void:
	spawn_tramp()
	$TrampTimer.wait_time = randf_range(2.5, 6.5)
