extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("box_jump") :
		body.box_jump(global_rotation)
