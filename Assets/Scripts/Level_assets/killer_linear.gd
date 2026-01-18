extends Area2D

@export var speed = 0.5
@export var distance = 100
@export var ReversedDirection : bool
@export var angle = 0.0
var time = 0.0
var original_pos : Vector2
@export var LineColor : Color
var line_origin : Vector2


func _ready() -> void:
	original_pos = global_position
	angle = -deg_to_rad(angle+90)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#rotate(TAU*delta)
	
	time += TAU*delta*speed
	if time > TAU :
		time = 0
	if ReversedDirection :
		global_position.x = sin(time)*distance*sin(angle) + original_pos.x
		global_position.y = sin(time)*distance*cos(angle) + original_pos.y
	else :
		global_position.x = -sin(time)*distance*sin(angle) + original_pos.x
		global_position.y = -sin(time)*distance*cos(angle) + original_pos.y
	
	
	queue_redraw()
	

func reset_position():
	time = 0

func _draw() -> void:
	if ReversedDirection :
		line_origin.x = -sin(time)*distance*sin(angle)+distance*-sin(angle)
		line_origin.y = -sin(time)*distance*cos(angle)+distance*-cos(angle)
	else :
		line_origin.x = sin(time)*distance*sin(angle)+distance*-sin(angle)
		line_origin.y = sin(time)*distance*cos(angle)+distance*-cos(angle)
	
	draw_line(line_origin, (line_origin + Vector2(distance*2*sin(angle), distance*2*cos(angle))), LineColor, 5, true)
