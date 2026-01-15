extends CharacterBody2D


const SPEED = 300.0
const AIRCONTROL_FORCE = 800.0
const JUMP_VELOCITY = -350.0
const ABOX_ACCEL = 750

const GRAVITY = 700.0


## Do I need to limit box max lenght ?

func _physics_process(delta: float) -> void:
	
	
	## Add the gravity.
	velocity += get_gravity() * delta
	##Custom gravity so I can easily change const value, might go back to get gravity and change the project parameter when adjusted
	#velocity.y += GRAVITY * delta


	if is_on_floor():
		
		##check plateform
		if %RayCast2D.is_colliding():
			var collider = %RayCast2D.get_collider()
			
			if collider is StaticBody2D :
				if collider.ISGROUND :
					pass
				else :
					if collider.angle :
						velocity.x += ABOX_ACCEL*delta
					else :
						velocity.x -= ABOX_ACCEL*delta
			
		


	move_and_slide()
	velocity=get_real_velocity()
	general.SoundTrack_player.volume_db = move_toward(general.SoundTrack_player.volume_db, velocity.x/200, 0.001)

#jump handler
func box_jump(angle : float):
	if abs(velocity.length())<abs(JUMP_VELOCITY):
		velocity.x += -sin(angle)*JUMP_VELOCITY
		velocity.y = cos(angle)*JUMP_VELOCITY
	else :
		velocity.x += sin(angle)*velocity.length()
		if abs(-cos(angle)*velocity.length())<abs(JUMP_VELOCITY):
			velocity.y = cos(angle)*JUMP_VELOCITY
		else :
			velocity.y = -cos(angle)*velocity.length()*0.75
