extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
	$ScoreTimer.stop()
	$Player.hide()
	$HUD.show_game_over()

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$Mob.start($TrampPosition.position)
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
