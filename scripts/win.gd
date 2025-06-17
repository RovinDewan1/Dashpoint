extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return  # Ignore anything that isn't a CharacterBody2D
	Gamelogic.gamewinloc = body.global_position
	Gamelogic.win()
