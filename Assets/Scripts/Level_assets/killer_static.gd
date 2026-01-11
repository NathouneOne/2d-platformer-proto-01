extends Area2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(TAU*delta)


func _on_body_entered(_body: Node2D) -> void:
	%Timer3.start()
	Engine.time_scale=0.1



func _on_timer_3_timeout() -> void:
	Engine.time_scale=1
	get_tree().reload_current_scene()
