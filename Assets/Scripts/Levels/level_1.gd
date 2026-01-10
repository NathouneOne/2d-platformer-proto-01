extends Node2D

@onready var timer: Timer = %Timer
const TIMER_TIME = 2
const BOX_Y_SIZE = 5

const GBOX_SELECTED = 0
const JBOX_SELECTED = 1
const SBOX_SELECTED = 2

const SLOWMO = 0.1

const J_BOX = preload("uid://bobxjb73lgyn3")
const G_BOX = preload("uid://mkowtkrnf7xq")

var clic1 : Vector2
var clic2 : Vector2
var selected_box : int = GBOX_SELECTED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	#Reset level on fall
	if %KillPlane.has_overlapping_bodies() :
		%Timer.start(TIMER_TIME)
	
	# Create a box if no time slow
	if not Input.is_action_pressed("right_clic"):
		if Input.is_action_just_pressed("left_clic"):
			clic1 = get_global_mouse_position()
		if Input.is_action_just_released("left_clic"):
			clic2 = get_global_mouse_position()
			create_box(clic1, clic2, selected_box)
	
	#Select type of box
	if Input.is_action_just_pressed("right_clic"):
		clic1 = get_global_mouse_position()
		#Slow_mo function 
		Engine.time_scale = SLOWMO
		#Add a dynamic box selection UI here
	if Input.is_action_just_released("right_clic"):
		clic2 = get_global_mouse_position()
		#End slow_mo
		Engine.time_scale = 1
		#End dynamic box selection UI here
		
		if clic1.angle_to_point(clic2) > 0 :
			selected_box=GBOX_SELECTED
			print("selected_box = GroundBox")
		else :
			selected_box=JBOX_SELECTED
			print("selected_box = JumpBox")
		

func create_box(box_coordinate_1 : Vector2, box_coordinate_2 : Vector2, box_type : int) :
	
	var box = J_BOX.instantiate()
	match box_type:
		GBOX_SELECTED :
			box = G_BOX.instantiate()
		JBOX_SELECTED :
			box = J_BOX.instantiate()
		SBOX_SELECTED :
			box = J_BOX.instantiate()
		
	
	var box_size = Vector2(box_coordinate_1.distance_to(box_coordinate_2), BOX_Y_SIZE)
	var box_angle = box_coordinate_1.angle_to_point(box_coordinate_2)
	
	
	box.global_position.x=box_coordinate_1.x
	box.global_position.y=box_coordinate_1.y
	
	box.get_child(1).position = Vector2(0,0)
	box.get_child(0).shape.size = box_size
	box.get_child(0).position.x=box_size.x/2
	box.get_child(0).position.y=box_size.y/2
	box.get_child(1).size = box_size
	#print("\n\nposition clic 1 : ", box_coordinate_1,"\nposition parent : ", box.global_position, "\nposition collisionShape : ", box.get_child(0).global_position, "\nposition rectangle affiché : ", box.get_child(1).global_position)
	box.global_rotation = box_angle
	
	
	
	add_child(box)


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
