extends Node2D

@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var hittimer: Timer = $Hittimer
@onready var punch: AudioStreamPlayer2D = $PUNCH



var direction = 0

func _physics_process(delta: float) -> void:
	pass

func _on_temp__no_killzone_yet_body_entered(_body: Node2D) -> void:
	if Dashing.dash == true:
		punch.play()
		Dashing.Dashcounter += 2
		Dashing.SPEED += 90
		await get_tree().create_timer(0.155).timeout
		queue_free()
	else:
		Gamelogic.gameover()



func _on_hittimer_timeout() -> void:
	pass
