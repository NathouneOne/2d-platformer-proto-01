extends StaticBody2D

const ISGROUND=1



func _ready() -> void:
	input_pickable = true

func _input(_event: InputEvent) -> void:
	var m_position=get_local_mouse_position()
	if (m_position.x <= %CollisionShape2D.shape.size.x and 
		m_position.x >= 0 and 
		m_position.y <= %CollisionShape2D.shape.size.y and 
		m_position.y>=0 ):
			
		if not Input.is_action_pressed("left_clic") and Input.is_action_pressed("right_clic") :
			queue_free()
