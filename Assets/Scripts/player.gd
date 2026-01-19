extends CharacterBody2D


signal player_died
signal player_win
signal slowmo_collected

const SPEED = 300.0
const AIRCONTROL_FORCE = 800.0
const JUMP_VELOCITY = -350.0
const ABOX_ACCEL = 750

const GRAVITY = 700.0

const KILLER_STATIC = preload("uid://2s6vndtoofk4")

var isDead = false

## Do I need to limit box max lenght ?

func _physics_process(delta: float) -> void:
	
	
	## Add the gravity.
	velocity += get_gravity() * delta


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



func _on_area_2d_area_entered(area: Area2D) -> void:

	if area.get_groups():
		if area.get_groups()[0] == "Killer":
			if not isDead :
				player_died.emit()
				isDead = true 
	elif area.name == "FinishLine" :
		player_win.emit()
	elif area.name == "CollectibleSlowmo" :
		slowmo_collected.emit()
		area.queue_free()
		
	
