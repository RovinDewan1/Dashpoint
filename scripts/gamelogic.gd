extends Node

var scene = preload("res://Scenes/Failscreen.tscn").instantiate()
var gameoverloc = Vector2.ZERO
var dead = false

func gameover():
	Engine.time_scale = 0
	var scene = preload("res://Scenes/Failscreen.tscn").instantiate()
	scene.position = gameoverloc
	scene.z_index = 100  # Set render order
	dead = true
	add_child(scene)

func reset():
	gameoverloc = 0
	dead = false
