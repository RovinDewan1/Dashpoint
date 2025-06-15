extends Node2D

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D


var direction = 0


func _on_temp__no_killzone_yet_body_entered(_body: Node2D) -> void:
	if Dashing.dash == true:
		Dashing.Dashcounter += 1
		Dashing.SPEED += 90
		queue_free()
	else:
		Gamelogic.gameover()
