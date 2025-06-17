extends AnimatedSprite2D
@onready var death: AnimatedSprite2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	death.play()
	await get_tree().create_timer(1).timeout
