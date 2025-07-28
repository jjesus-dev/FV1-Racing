extends Area2D

signal coin_collected(coin_value)

var coin_types = {
	"gray": 10,
	"yellow": 20,
	"red": 30,
}
var coin = "red"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_coin = coin_types.keys().pick_random()
	coin = random_coin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match coin:
		"gray":
			$AnimatedSprite2D.play("gray")
		"yellow":
			$AnimatedSprite2D.play("yellow")
		"red":
			$AnimatedSprite2D.play("red")


func _on_body_entered(_body: Node2D) -> void:
	print("Moneda recogida: %s (%d pts)" % [coin, coin_types[coin]])
	coin_collected.emit(coin_types[coin])
	queue_free()
