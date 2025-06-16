extends CharacterBody2D



const JUMP_VELOCITY = -300.0
var timeleft = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var Dash_timer: Timer = %"Dash-Recharge-Timer"
@onready var delay: Timer = %delay
@onready var dashes: Label = %Dashes
@onready var time: Label = %Time 
@onready var jump: AudioStreamPlayer2D = $"../Jump"
@onready var run: AudioStreamPlayer2D = $"../run"






var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta




	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()

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
		Dashing.dash = false
		if direction ==0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
			run.play() 
	else:
		animated_sprite_2d.play("jump")
	
	if direction:
		velocity.x = direction * Dashing.SPEED
		if Dashing.SPEED >= 230:
			if Dashing.SPEED > 230:
				Dashing.SPEED -= 20
				if is_on_floor():
					Dashing.SPEED = Dashing.SPEED - (Dashing.SPEED-230)
				#print(SPEED)
			pass
		else:
			Dashing.SPEED += 1 #speed gain over time
			#print(SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, Dashing.SPEED)
		if Dashing.SPEED <= 130:
			if Dashing.SPEED < 130:
				Dashing.SPEED = 130 # if speed is below 130, set to 130
			pass
		else:
			Dashing.SPEED -= 10 #speed decay
			#print(SPEED)
#dash setup
	if delay.is_stopped() == true:
		if Input.is_action_pressed("Jump") and Input.is_action_pressed("Dash") and Dashing.Dashcounter > 0:
				Dashing.dash = true
				velocity.y = JUMP_VELOCITY-150
				Dashing.Dashcounter -= 1
				print(Dashing.Dashcounter)
				delay.start()
				jump.play()
				dashcheck()

		elif Input.is_action_just_pressed("Dash") and Dashing.Dashcounter > 0:
			Dashing.dash = true
			velocity.y = JUMP_VELOCITY+150
			for i in range(6):
				Dashing.SPEED += 100
			Dashing.Dashcounter -= 1
			print(Dashing.Dashcounter)
			delay.start()
			jump.play()
			dashcheck()
	
	timeleft = snapped(Dash_timer.time_left, 0.1)
	dashes.text = str(Dashing.Dashcounter)
	time.text = str(timeleft)
	
	move_and_slide()
	#print(dashing.SPEED)
	#print(dashing.dash)
#dash-----------


func dashcheck():
	print("checking")
	if Dashing.Dashcounter >= 3:
		print("Too many dashes,skipping")
	else:
		print("below max, recharging ")
		on_recharge_timer_ready()

func on_recharge_timer_ready() -> void:
	Dash_timer.start()
	print("timer starting")


func on_recharge_timer_timeout() -> void:
	print("stopped, adding dash")
	Dashing.Dashcounter += 1
	print(Dashing.Dashcounter)
	dashcheck()
#-------------------
