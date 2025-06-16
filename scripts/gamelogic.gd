extends Node

var scene = preload("res://Scenes/Failscreen.tscn").instantiate()
var gameoverloc = 0
func gameover():
	Engine.time_scale = 0
	scene.position = gameoverloc
	scene.z_index = 100  # Set render order
	add_child(scene)
	print("fucke")
