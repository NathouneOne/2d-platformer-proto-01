extends Control

const MAIN = "uid://dhi4esrgo13w"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(MAIN)
	
