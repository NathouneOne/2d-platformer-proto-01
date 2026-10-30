extends Control

signal next_level
signal restart_level
signal select_level
signal options



func _on_next_button_pressed() -> void:
	next_level.emit()


func _on_restart_button_pressed() -> void:
	restart_level.emit()


func _on_quit_button_pressed() -> void:
		get_tree().quit()


func _on_select_button_pressed() -> void:
	select_level.emit()


func _on_option_button_pressed() -> void:
	options.emit()
