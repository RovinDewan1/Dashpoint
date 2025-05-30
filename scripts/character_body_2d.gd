extends CharacterBody2D


var SPEED = 130
const JUMP_VELOCITY = -300.0
var Dashcounter = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var Dash_timer: Timer = %"Dash-Recharge-Timer"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

#timer
	Dash_timer.start()
	print("timer start")
	func on_recharge_timer_timeout():
		print("timer end")
#



	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	#gets direction, -1, 0 , 1
	
	
	#flip sprite 
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction <0:
		animated_sprite_2d.flip_h = true
	
	#play anim
	if is_on_floor():
		if direction ==0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

#dash setup
	if Input.is_action_just_pressed("Dash") and Dashcounter > 0:
		print(Dashcounter)
		velocity.y += JUMP_VELOCITY
		velocity.x += direction * (SPEED * 10)
		Dashcounter = 0
	
	#dash recharge timer
	
	
	
	#-------




	move_and_slide()


func on_recharge_timer_ready() -> void:
	pass # Replace with function body.


func on_recharge_timer_timeout() -> void:
	pass # Replace with function body.
