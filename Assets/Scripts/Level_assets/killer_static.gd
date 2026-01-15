extends Area2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(TAU*delta)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		general.death()
