extends Area2D

@export var speed = 0.5
@export var distance = 100
@export var angular_starting_pos_deg = 180
@export var ReversedDirection : bool
var time = 0.0
var original_pos : Vector2

func _ready() -> void:
	original_pos = global_position
	time = deg_to_rad(angular_starting_pos_deg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(TAU*delta)
	
	time += TAU*delta*speed
	if time > TAU :
		time = 0
	if ReversedDirection :
		global_position.x = sin(time)*distance + original_pos.x
		global_position.y = cos(time)*distance + original_pos.y
	else :
		global_position.x = sin(time)*distance + original_pos.x
		global_position.y = -cos(time)*distance + original_pos.y

func reset_position():
	time = 0
