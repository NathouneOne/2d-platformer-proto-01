extends Node2D

const BOX_Y_SIZE = 10

const JBOX_SELECTED = 4
const GBOX_SELECTED = 3
const ABOX_SELECTED = 2
const ERASER_SELECTED=1

const SLOWMO = 0.1

const J_BOX = preload("uid://bobxjb73lgyn3")
const G_BOX = preload("uid://mkowtkrnf7xq")
const A_BOX = preload("uid://bqg3u2yv56sun")

const G_TEXTURE = preload("uid://cid65dv7rhtkb")
const J_TEXTURE = preload("uid://cn54on8cehkmr")
const A_TEXTURE = preload("uid://0bc82ijt3a18")

#Sounds
const DEATH_HIGH_DEF = preload("uid://1wmdrd0svocb")

const ESC_SCREEN = "uid://crgbo6r4vnr3v"
const WIN_SCREEN = "uid://dmepa88lyqd8o"


var clic1 : Vector2
var clic2 : Vector2
var selected_box : int = GBOX_SELECTED

var current_box = G_BOX.instantiate()

var shader_aberration = 0.0
var shader_strength = 0.0
const SHADER_ABERRATION_DIVIDER = 4000
const SHADER_STRENGTH_DIVIDER = 20000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Player.get_child(2).texture = G_TEXTURE
	%Shader.material.set_shader_parameter('aberration',shader_aberration)
	%Shader.material.set_shader_parameter('strength',shader_strength)
	Engine.time_scale=1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#F1 for quick reload scene
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("esc"):
		Engine.time_scale=1
		get_tree().change_scene_to_file(ESC_SCREEN)
		
		
	
	if Input.is_action_pressed("slowmo"):
		if %SlowMo_charge.get_child(1).size.x > 0 :
			Engine.time_scale=SLOWMO
			%SlowMo_charge.get_child(1).size.x -= delta*1000
		else : 
			Engine.time_scale=1
	
	if Input.is_action_just_released("slowmo") :
		Engine.time_scale=1
			
	#Adapt shader
	shader_aberration = move_toward(shader_aberration, clamp(abs(%Player.velocity.x/SHADER_ABERRATION_DIVIDER), 0, 1.5), 0.01)
	shader_strength = move_toward(shader_strength, clamp(abs(%Player.velocity.x/SHADER_STRENGTH_DIVIDER), 0, 0.1), 0.001)
	%Shader.material.set_shader_parameter('aberration',shader_aberration)
	%Shader.material.set_shader_parameter('strength',shader_strength)
	
	# Fix camera on y, allowing only X to move.
	%Camera2D.global_position.y=0
	
	# Create and update box 
	if Input.is_action_just_pressed("left_clic"):
		clic1 = get_global_mouse_position()
		clic2 = get_global_mouse_position()
		current_box = create_box(clic1, clic2, selected_box)
	
	if Input.is_action_pressed("left_clic"):
		clic2 = get_global_mouse_position()
		update_box(clic1, clic2, current_box)
	
	if Input.is_action_just_released("left_clic"):
		clic2 = get_global_mouse_position()
		
		#Trying to replace box on release under player if collision to avoid unwanted jumps
		if current_box==StaticBody2D :
			for i in current_box.get_child(2).get_overlapping_bodies() :
				if i == %Player :
					clic1.y += %Player.get_child(0).shape.size.y/2
					clic2.y += %Player.get_child(0).shape.size.y/2
				
			
		current_box.set_collision_layer(1)
		current_box.set_collision_mask(1)
		
		update_box(clic1, clic2, current_box)
		
		##if Acceleration box, pass the right/left acceleration variable
		if selected_box == ABOX_SELECTED :
			if clic1.x>clic2.x :
				current_box.angle = 0
			else :
				current_box.angle = 1
				
			
	
	#Select type of box
	if not Input.is_action_pressed("left_clic"):
		if Input.is_action_just_pressed("A") : 
			selected_box=GBOX_SELECTED
			%Player.get_child(2).texture = G_TEXTURE
		if Input.is_action_just_pressed("Z") : 
			selected_box=JBOX_SELECTED
			%Player.get_child(2).texture = J_TEXTURE
		if Input.is_action_just_pressed("E") : 
			selected_box=ABOX_SELECTED
			%Player.get_child(2).texture = A_TEXTURE
		


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
	
	box.set_collision_layer(0)
	box.set_collision_mask(0)
	
	update_box(box_coordinate_1, box_coordinate_2, box)
	
	add_child(box)
	
	return box


func update_box(box_coordinate_1 : Vector2, box_coordinate_2 : Vector2, box : Node):
	if box == StaticBody2D :
		pass
	
	var box_size = Vector2(box_coordinate_1.distance_to(box_coordinate_2), BOX_Y_SIZE)
	var box_angle = box_coordinate_1.angle_to_point(box_coordinate_2)
	
	#position box, collision_shape & skin
	box.global_position.x=box_coordinate_1.x
	box.global_position.y=box_coordinate_1.y
	
	box.get_child(1).position = Vector2(0,0)
	box.get_child(1).size = box_size
	box.get_child(0).shape.size = box_size
	box.get_child(0).position.x=box_size.x/2
	box.get_child(0).position.y=box_size.y/2
	
	
	if box == StaticBody2D :
		box.get_child(2).get_child(0).shape.size = box_size
		box.get_child(2).get_child(0).position.x=box_size.x/2
		box.get_child(2).get_child(0).position.y=box_size.y/2
	
	box.global_rotation = box_angle


func _on_kill_plane_body_entered(body: Node2D) -> void:
	if body == %Player :
		general.death()

#
#func _on_timer_timeout() -> void:
#	Engine.time_scale=1
#	get_tree().reload_current_scene()
#
