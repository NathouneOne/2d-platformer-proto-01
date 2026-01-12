extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		%Timer2.start()
		Engine.time_scale=0.1

func _on_timer_2_timeout() -> void:
	Engine.time_scale=1
	get_tree().reload_current_scene()
