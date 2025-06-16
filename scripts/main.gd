extends Node2D
@onready var music: AudioStreamPlayer = $"15MinutesOfVideoGameMusic-DangerousBlackFromMegaManBattleNetwork3-Ace9921"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()
	

func _physics_process(delta: float) -> void:
	if Gamelogic.dead == true:
		music.stop()
