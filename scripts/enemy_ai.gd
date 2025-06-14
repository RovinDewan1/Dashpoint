extends Node2D

const SPEED = 60

var direction = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * 60 * delta
