extends Area2D

@export var color : Color
var radius = 0.0
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radius = %CollisionShape2D.shape.radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta*4
	radius = move_toward(radius, %CollisionShape2D.shape.radius - float((int(time*100) % 200))/50, 0.1) 
	#print(radius)
	queue_redraw()
	

func _draw() :
	draw_circle(Vector2(0,00), radius, color, false, 7, true)
