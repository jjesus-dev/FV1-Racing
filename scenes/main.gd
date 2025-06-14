extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
	$Player.hide()

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$Mob.start($TrampPosition.position)

func _ready() -> void:
	new_game()
