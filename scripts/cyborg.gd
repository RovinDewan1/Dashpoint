extends Node2D

const SPEED = 60

var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * SPEED * delta
