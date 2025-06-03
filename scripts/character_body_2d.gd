extends CharacterBody2D


var SPEED = 130
const JUMP_VELOCITY = -300.0
var Dashcounter = 3

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var Dash_timer: Timer = %"Dash-Recharge-Timer"


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta




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
		if SPEED >= 390:
			if SPEED > 390:
				SPEED -= 2
				if is_on_floor():
					SPEED = SPEED - (SPEED-390)
				#print(SPEED)
			pass
		else:
			SPEED += 1 #speed gain over time
			#print(SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if SPEED <= 130:
			if SPEED < 130:
				SPEED = 130 # if speed is below 130, set to 130
			pass
		else:
			SPEED -= 10 #speed decay
			#print(SPEED)
#dash setup
	if Input.is_action_just_pressed("Dash") and Dashcounter > 0:
		velocity.y = JUMP_VELOCITY+150
		for i in range(5):
			SPEED += 20
		Dashcounter -= 1
		print(Dashcounter)
		dashcheck()

	move_and_slide()

#dash-----------

func dashcheck():
	print("checking")
	if Dashcounter >= 3:
		print("Too many dashes,skipping")
	else:
		print("below max, recharging ")
		on_recharge_timer_ready()

func on_recharge_timer_ready() -> void:
	Dash_timer.start()
	print("timer starting")


func on_recharge_timer_timeout() -> void:
	print("stopped, adding dash")
	Dashcounter += 1
	print(Dashcounter)
	dashcheck()
#-------------------
