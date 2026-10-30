extends Control

signal level1button
signal continuebutton
signal levelselectbutton
signal option_button


func _on_level_1_pressed() -> void:
	get_parent().current_level_index = 0
	level1button.emit()


func _on_continue_pressed() -> void:
	continuebutton.emit()


func _on_select_level_pressed() -> void:
	levelselectbutton.emit()


func _on_exit_to_deskstop_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	option_button.emit()
