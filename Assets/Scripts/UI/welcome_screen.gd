extends Control





func _on_level_1_pressed() -> void:
	get_parent().current_level_index=0


func _on_continue_pressed() -> void:
	get_parent().current_level_index=get_parent().max_level_index


func _on_select_level_pressed() -> void:
	pass # Replace with function body.
