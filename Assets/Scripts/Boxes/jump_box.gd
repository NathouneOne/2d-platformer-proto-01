extends Area2D


func _ready() -> void:
	input_pickable = true
	
#Set les layers pour détercter que le player, ça allegera le programme
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("box_jump") :
		body.box_jump(global_rotation)


## eraser handling

func _input(_event: InputEvent) -> void:
	var m_position=get_local_mouse_position()
	if (m_position.x <= %CollisionShape2D.shape.size.x and 
		m_position.x >= 0 and 
		m_position.y <= %CollisionShape2D.shape.size.y and 
		m_position.y>=0 ):
			
		if Input.is_action_pressed("left_clic") and get_parent().selected_box ==1 :
			queue_free()


#func _mouse_enter() -> void:
#	if get_parent().selected_box == 1 and Input.is_action_pressed("left_clic"):
#		queue_free()
#		
#func _mouse_exit() -> void:
#	if get_parent().selected_box == 1 and Input.is_action_pressed("left_clic"):
#		queue_free()
