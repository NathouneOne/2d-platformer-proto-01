extends Control

const MAIN = "uid://dhi4esrgo13w"


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc") :
		get_tree().change_scene_to_file(MAIN)



func _on_button_pressed() -> void:
	get_tree().quit()
