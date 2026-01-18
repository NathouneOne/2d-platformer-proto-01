extends Area2D

@export var speed = 0.5
@export var distance = 100
@export var angular_starting_pos_deg = 180
@export var ReversedDirection : bool
var time = 0.0
var original_pos : Vector2
@export var CircleColor : Color

var circle_anchor = Vector2(0.0,0.0)

func _ready() -> void:
	original_pos = global_position
	time = deg_to_rad(angular_starting_pos_deg)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time += TAU*delta*speed
	if time > TAU :
		time = 0
	if ReversedDirection :
		global_position.x = sin(time)*distance + original_pos.x
		global_position.y = cos(time)*distance + original_pos.y
	else :
		global_position.x = sin(time)*distance + original_pos.x
		global_position.y = -cos(time)*distance + original_pos.y
		
	queue_redraw()
	
	
func reset_position():
	time = 0


func _draw() -> void:
	if ReversedDirection :
		circle_anchor.x = -sin(time)*distance
		circle_anchor.y = -cos(time)*distance
	else :
		circle_anchor.x = -sin(time)*distance
		circle_anchor.y = +cos(time)*distance
		
	draw_circle(circle_anchor, distance, CircleColor, false, 5, true)
