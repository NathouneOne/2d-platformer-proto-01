extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0

const GRAVITY = 700.0


func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
	##Custom gravity so I can easily change const value, might go back to get gravity and change the project parameter when adjusted
	velocity.y += GRAVITY * delta
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, 1) 		##Ralentissement horizontal je sais pas si on garde --> on garde pas on veut du SPEEDRUUUUUUNNNNNNN

	move_and_slide()


func box_jump(angle : float):
	velocity.x = -sin(angle)*JUMP_VELOCITY
	velocity.y = cos(angle)*JUMP_VELOCITY
