extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func reset_position():
	if %CollisionPolygon2D :
		%CollisionPolygon2D.rotation = 0
		%PinkTriangle.rotation = 0
