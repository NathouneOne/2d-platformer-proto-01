extends CharacterBody2D


const SPEED = 300.0
const AIRCONTROL_FORCE = 800.0
const JUMP_VELOCITY = -500.0
const ABOX_ACCEL = 25

const GRAVITY = 700.0

#func _ready() -> void:
#	apply_floor_snap()
#	floor_snap_length=10
	


## Do I need to limit box max lenght ?
## Accelerator box ?
## eraser ?

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#	velocity += get_gravity() * delta
	##Custom gravity so I can easily change const value, might go back to get gravity and change the project parameter when adjusted
	velocity.y += GRAVITY * delta
	#if is_on_floor() :
	#	velocity.y=GRAVITY
	## Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#var direction := Input.get_axis("left", "right")
	

	
	## Movement only on ground_boxes
	## WARNING Might have bugs on ground detection when inertia due to get_slide_collision not detecting in down slopes
	## raycast seems ok !

	if is_on_floor():
		
		##check plateform
		if %RayCast2D.is_colliding():
			var collider = %RayCast2D.get_collider()
			
			if collider is StaticBody2D :
				if collider.ISGROUND :
					#if direction:
					#	## apply direction with acceleration
					#	if direction == 1:
					#		velocity.x = move_toward(velocity.x, SPEED, SPEED/4)
					#	else:
					#		velocity.x = move_toward(velocity.x, -SPEED, SPEED/4)
					##Ralentissement horizontal que si sur ground_box on veut du SPEEDRUUUUUUNNNNNNN
					#else:
					#	velocity.x = move_toward(velocity.x, 0, SPEED/4) 
					pass
				else :
					print(collider.angle)
					if collider.angle :
						velocity.x += ABOX_ACCEL
					else :
						velocity.x -= ABOX_ACCEL
			
		
	## WARNING limit left aircontrol ? or remove input totally anyway
	## allowing right direction air control in the scope of SPEED for jump control, left is always allowed to brake whatever your speed, you aim to go to the right anyway, right ?
	#elif (direction == 1 and (velocity.x<=SPEED)) or direction == -1:
	#	velocity.x += direction * AIRCONTROL_FORCE * delta
	
	move_and_slide()
	velocity=get_real_velocity()


func box_jump(angle : float):
	velocity.x = -sin(angle)*JUMP_VELOCITY
	velocity.y = cos(angle)*JUMP_VELOCITY
