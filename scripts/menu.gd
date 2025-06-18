extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	Gamelogic.stopwatch = true
	Gamelogic.starttime = Time.get_ticks_msec()

func _on_quit_pressed() -> void:
	get_tree().quit()
