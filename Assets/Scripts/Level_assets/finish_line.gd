extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D :
		general.store_best_score(get_parent().get_parent().get_child(3).get_child(0).elapsed_time)
		general.death()
