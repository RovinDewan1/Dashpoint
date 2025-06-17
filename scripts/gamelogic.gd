extends Node

var gameoverloc = Vector2.ZERO
var gamewinloc = Vector2.ZERO
var dead = false

func gameover():
	Engine.time_scale = 0
	var scene = preload("res://Scenes/Failscreen.tscn").instantiate()
	scene.position = gameoverloc
	scene.z_index = 100  # Set render order
	dead = true
	add_child(scene)

func win():
	Engine.time_scale = 0
	var win = preload("res://Scenes/Win.tscn").instantiate()
	win.position = gamewinloc
	win.z_index = 100  # Set render order
	add_child(win)




func reset():
	gameoverloc = Vector2.ZERO
	gamewinloc = Vector2.ZERO
	dead = false
