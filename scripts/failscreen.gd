extends Control


func _on_restart_pressed() -> void:
	Engine.time_scale = 1
	Dashing.reset()
	Gamelogic.reset()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()
