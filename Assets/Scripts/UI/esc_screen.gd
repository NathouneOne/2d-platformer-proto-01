extends CanvasLayer

signal option_button
signal select_level_button

func _process(_delta : float) -> void:
	if get_parent().best_score.size()>0:
		var t = str("High scores")
		var a=1
		for i in get_parent().best_score :
			t+=(str("\nlevel ", a, " = ", float(int(i*100)/100.0)))
			a+= 1
		
		%Label2.text = t
		


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_select_level_pressed() -> void:
	select_level_button.emit()


func _on_options_pressed() -> void:
	option_button.emit()
