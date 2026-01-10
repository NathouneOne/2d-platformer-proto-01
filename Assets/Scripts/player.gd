extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

const GRAVITY = 700.0


func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
	##Custom gravity so I can easily change const value, might go back to get gravity and change the project parameter when adjusted
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	## Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	## Movement only on ground_boxes
	if is_on_floor():
		if direction:
			#velocity.x = direction * SPEED ##instant acceleration
			if direction == 1:
				velocity.x = move_toward(velocity.x, SPEED, SPEED/4)
			else:
				velocity.x = move_toward(velocity.x, -SPEED, SPEED/4)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED/4) 		##Ralentissement horizontal que si sur ground_box on garde pas on veut du SPEEDRUUUUUUNNNNNNN
	else :
		if direction and (velocity.x>-SPEED and velocity.x<SPEED):
			velocity.x += direction * SPEED * delta

	move_and_slide()


func box_jump(angle : float):
	velocity.x = -sin(angle)*JUMP_VELOCITY
	velocity.y = cos(angle)*JUMP_VELOCITY
