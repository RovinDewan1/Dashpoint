extends Node2D

@onready var hittimer: Timer = $Hittimer
@onready var punch: AudioStreamPlayer2D = $PUNCH
@onready var character: Node2D = %Character
@onready var death: AudioStreamPlayer2D = $death



var direction = 0

func _physics_process(delta: float) -> void:
	pass

func _on_temp__no_killzone_yet_body_entered(_body: Node2D) -> void:
	if not _body is CharacterBody2D:
		return  # Ignore anything that isn't a CharacterBody2D
	
	if Dashing.dash == true:
		#print("taketh") #debug
		punch.play()
		Dashing.Dashcounter += 2
		Dashing.SPEED += 400
		Engine.time_scale = .2
		await get_tree().create_timer(0.1).timeout
		Engine.time_scale = 1
		await get_tree().create_timer(0.155).timeout
		queue_free()
	else:
		Gamelogic.gameoverloc = _body.global_position
		print("Game over triggered at position:", Gamelogic.gameoverloc)
		Gamelogic.gameover()
		death.play()



func _on_hittimer_timeout() -> void:
	pass
