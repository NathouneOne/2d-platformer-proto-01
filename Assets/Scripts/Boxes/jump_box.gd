extends Area2D


#Set les layers pour détercter que le player, ça allegera le programme
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("box_jump") :
		body.box_jump(global_rotation)


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
