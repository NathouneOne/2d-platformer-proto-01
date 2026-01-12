extends Node2D

@onready var timer: Timer = %Timer
const TIMER_TIME = 0.5
const BOX_Y_SIZE = 10

const JBOX_SELECTED = 4
const GBOX_SELECTED = 3
const ABOX_SELECTED = 2
const ERASER_SELECTED=1

const SLOWMO = 0.1

const J_BOX = preload("uid://bobxjb73lgyn3")
const G_BOX = preload("uid://mkowtkrnf7xq")
const A_BOX = preload("uid://bqg3u2yv56sun")

var clic1 : Vector2
var clic2 : Vector2
var selected_box : int = GBOX_SELECTED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Set selector opacity
	%UI_box_wheel_selector.modulate.a=0.6
	#var camera_size = get_viewport_rect().size
	#%Camera2D.global_position.y=camera_size.y/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	
	
	# Fix camera on y, allowing only X to move.
	%Camera2D.global_position.y=0
	
	
	# Create a box if not in box selection
	if not Input.is_action_pressed("right_clic"):
		if Input.is_action_just_pressed("left_clic"):
			if selected_box == ERASER_SELECTED :
				pass
			else :
				clic1 = get_global_mouse_position()
		if Input.is_action_just_released("left_clic"):
			if selected_box == ERASER_SELECTED :
				pass
			else :
				clic2 = get_global_mouse_position()
				create_box(clic1, clic2, selected_box)
	
	#Select type of box
	if Input.is_action_just_pressed("right_clic"):
		clic1 = get_global_mouse_position()
		#Slow_mo function 
		Engine.time_scale = SLOWMO
		#Add a dynamic box selection UI here
		%UI_box_wheel_selector.global_position=clic1
		%UI_box_wheel_selector.show()
		
	if Input.is_action_just_released("right_clic"):
		#End slow_mo
		Engine.time_scale = 1
		#End dynamic box selection UI here
		if %UI_box_wheel_selector.selection :
			selected_box=%UI_box_wheel_selector.selection
		%UI_box_wheel_selector.hide()
		
		

#create a typed box, called when left click is pressed and released, and eraser is not selected
func create_box(box_coordinate_1 : Vector2, box_coordinate_2 : Vector2, box_type : int) :
	
	#select box type
	var box = G_BOX.instantiate()
	match box_type:
		GBOX_SELECTED :
			box = G_BOX.instantiate()
		JBOX_SELECTED :
			box = J_BOX.instantiate()
		ABOX_SELECTED :
			box = A_BOX.instantiate()
	
	
	var box_size = Vector2(box_coordinate_1.distance_to(box_coordinate_2), BOX_Y_SIZE)
	var box_angle = box_coordinate_1.angle_to_point(box_coordinate_2)
	
	#if Acceleration box, pass the right/left acceleration variable
	if box_type == ABOX_SELECTED :
		if box_coordinate_1.x>box_coordinate_2.x :
			box.angle = 0
		else :
			box.angle = 1
	
	#position box, collision shape & skin
	box.global_position.x=box_coordinate_1.x
	box.global_position.y=box_coordinate_1.y
	
	box.get_child(1).position = Vector2(0,0)
	box.get_child(1).size = box_size
	box.get_child(0).shape.size = box_size
	box.get_child(0).position.x=box_size.x/2
	box.get_child(0).position.y=box_size.y/2
	
	box.global_rotation = box_angle
	
	
	add_child(box)




func _on_kill_plane_body_entered(body: Node2D) -> void:
	if body == %Player :
		get_tree().reload_current_scene()
