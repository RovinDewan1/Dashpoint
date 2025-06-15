extends Node2D

@onready var dashing: Node = %Dashing
@onready var temp___no_killzone_yet: Area2D = $"TEMP - NO KILLZONE YET"
@onready var collision_shape_2d: CollisionShape2D = $"TEMP - NO KILLZONE YET/CollisionShape2D"


var direction = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.x += direction * 60 * delta
	pass


func _on_temp__no_killzone_yet_body_entered(body: Node2D) -> void:
	print("tapaa") #so, this works?
	if dashing.dash == true: #but all of this doesnt? fix this code monkey, you don't deserve freedom
		print("touched")
		dashing.Dashcounter +=2
		queue_free()
