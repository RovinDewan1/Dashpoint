extends Node2D
@export var Bullet : PackedScene = preload("res://Scenes/Bullet.tscn")
const SPEED = 20
@onready var bulletorigin: Marker2D = $"bulletorigin"
@onready var characterlocation: Marker2D = $CharacterBody2D/Characterlocation


var direction = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mover: Timer = $mover


func _on_area_2d_body_entered(body: Node2D) -> void:
	var b = Bullet.instantiate()
	b.global_position = bulletorigin.global_position
	owner.add_child(b)
	
