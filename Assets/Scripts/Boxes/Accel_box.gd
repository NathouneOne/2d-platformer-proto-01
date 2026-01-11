extends StaticBody2D

const ISGROUND=0
var angle = 0



## eraser handling
func _on_mouse_entered() -> void:
	
	## check if eraser selected
	if get_parent().selected_box == 1 and Input.is_action_pressed("left_clic"):
		queue_free()



##double check eraser handling because unknown issues, not much better I would say...
func _on_mouse_exited() -> void:
	## check if eraser selected
	if get_parent().selected_box == 1 and Input.is_action_pressed("left_clic"):
		queue_free()
