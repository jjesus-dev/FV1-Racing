extends Area2D

var coin_types = {
	"gray": 10,
	"yellow": 20,
	"red": 30,
}
var coin = "red"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match coin:
		"gray":
			$AnimatedSprite2D.play("gray")
		"yellow":
			$AnimatedSprite2D.play("yellow")
		"red":
			$AnimatedSprite2D.play("red")
		_:
			print("¡No hay moneda!")


func _on_body_entered(body: Node2D) -> void:
	print("Moneda recogida")
