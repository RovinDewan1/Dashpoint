extends Node

var gameoverloc = Vector2.ZERO
var gamewinloc = Vector2.ZERO
var dead = false
var stopwatch = false
var starttime = 0
var calctime: float = 0
var mstime: float = 0


func gameover():
	Engine.time_scale = 0
	var scene = preload("res://Scenes/Failscreen.tscn").instantiate()
	scene.position = gameoverloc
	scene.z_index = 100  # Set render order
	dead = true
	stopwatch = false
	add_child(scene)

func win():
	Engine.time_scale = 0
	var win = preload("res://Scenes/Win.tscn").instantiate()
	win.position = gamewinloc
	win.z_index = 100  # Set render order
	stopwatch = false
	add_child(win)




func reset():
	gameoverloc = Vector2.ZERO
	gamewinloc = Vector2.ZERO
	dead = false
	
#timer

func _process(delta: float) -> void:
	if stopwatch == true:
		mstime = Time.get_ticks_msec() - starttime
		calctime = mstime/1000
