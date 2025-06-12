extends Node2D
@export var Bullet : PackedScene = preload("res://Scenes/Bullet.tscn")
const SPEED = 20
@onready var bulletorigin: Marker2D = $"bulletorigin"
@onready var characterlocation: Marker2D = $CharacterBody2D/Characterlocation
@onready var enemy_ai: Node2D = $"."

var direction = 0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var mover: Timer = $mover

'''
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Use deferred call to avoid physics state error
	call_deferred("_spawn_bullet", body)

func _spawn_bullet(body: Node2D) -> void:
	var bullet_instance = Bullet.instantiate()
	get_tree().current_scene.add_child(bullet_instance)

	# Position the bullet at the bulletorigin marker
	bullet_instance.global_position = bulletorigin.global_position

	# Optional: set direction if method exists on bullet
	if bullet_instance.has_method("set_direction"):
		var dir = (body.global_position - bulletorigin.global_position).normalized()
		bullet_instance.set_direction(dir)
'''
