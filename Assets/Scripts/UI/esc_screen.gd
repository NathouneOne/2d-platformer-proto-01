extends Control


func _process(_delta : float) -> void:
	if get_parent().best_score != null :
		%Label2.text = str("Session high score = ", float(int(get_parent().best_score*100)/100.0))


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	pass # Replace with function body.
