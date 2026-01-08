extends Node2D

@onready var timer: Timer = %Timer
const TIMER_TIME = 2
const BOX_Y_SIZE = 5

const CLIC_BOX = preload("uid://bobxjb73lgyn3")

var clic1 : Vector2
var clic2 : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if %KillPlane.has_overlapping_bodies() :
		%Timer.start(TIMER_TIME)
	
	if Input.is_action_just_pressed("left_clic"):
		clic1 = get_global_mouse_position()
	if Input.is_action_just_released("left_clic"):
		clic2 = get_global_mouse_position()
		create_box(clic1, clic2)
		
		


func create_box(box_coordinate_1 : Vector2, box_coordinate_2 : Vector2) :
	var clic_box = CLIC_BOX.instantiate()
	
	var box_size = Vector2(box_coordinate_1.distance_to(box_coordinate_2), BOX_Y_SIZE)
	var box_angle = box_coordinate_1.angle_to_point(box_coordinate_2)
	
	
	clic_box.global_position.x=box_coordinate_1.x
	clic_box.global_position.y=box_coordinate_1.y
	
	clic_box.get_child(1).position = Vector2(0,0)
	clic_box.get_child(0).shape.size = box_size
	clic_box.get_child(0).position.x=box_size.x/2
	clic_box.get_child(1).size = box_size
	print("\n\nposition clic 1 : ", box_coordinate_1,"\nposition parent : ", clic_box.global_position, "\nposition collisionShape : ", clic_box.get_child(0).global_position, "\nposition rectangle affiché : ", clic_box.get_child(1).global_position)
	clic_box.global_rotation = box_angle
	
	
	
	add_child(clic_box)


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
