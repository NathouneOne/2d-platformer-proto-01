extends Node



func death() :
	var timer := Timer.new()
	add_child(timer)
	timer.one_shot=true
	timer.wait_time = 0.15
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	Engine.time_scale=0.1

func _on_timer_timeout() -> void:
		Engine.time_scale=1
		get_tree().reload_current_scene()
