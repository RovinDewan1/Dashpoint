
extends Node

var SPEED = 130
var dash: bool = false
var Dashcounter = 3

#Genuinely singletons took so fucking long to figure out. im so sorry.
func _ready() -> void:
	pass  # You can leave this empty for now

func reset():
	Dashcounter = 3
	SPEED = 130
	dash = false
