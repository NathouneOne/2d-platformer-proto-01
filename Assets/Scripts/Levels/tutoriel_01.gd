extends Node2D


var need_slowmo_at_start = 0
var label = Node



func _on_slowmo_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		Engine.time_scale = 0.2
		label = Label.new()
		label.global_position = Vector2(1800, 250)
		label.text = "try left click and drag"
		label.mouse_filter=Control.MOUSE_FILTER_IGNORE
		add_child(label)
		


func _on_slowmo_area_body_exited(body: Node2D) -> void:
	if body.name == "Player" :
		Engine.time_scale = 1
		label.queue_free()
