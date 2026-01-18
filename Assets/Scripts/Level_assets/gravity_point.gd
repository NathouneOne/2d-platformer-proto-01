extends Area2D

@export var zoneColor : Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#gravity_point_unit_distance = %CollisionShape2D.shape.radius/2
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	draw_circle(Vector2(0.0,0.0), %CollisionShape2D.shape.radius, zoneColor, true, 5.0, true)
