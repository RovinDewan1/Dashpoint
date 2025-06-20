extends CharacterBody2D



const JUMP_VELOCITY = -300.0
var timeleft = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var Dash_timer: Timer = %"Dash-Recharge-Timer"
@onready var delay: Timer = %delay
@onready var dashes: Label = %Dashes
@onready var time: Label = %Time
@onready var running: AudioStreamPlayer2D = $"../Running"
@onready var jump: AudioStreamPlayer2D = $"../Jump"
@onready var stopwatch: Label = $Camera2D/Stopwatch
var minutes =  0
var sec: float = 0 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var minsub = 0


func _ready():
	if Dash_timer.is_stopped() == false:
		Dash_timer.stop()
	if delay.is_stopped() == false:
		delay.stop()
	if not Dash_timer.timeout.is_connected(on_recharge_timer_timeout):
		Dash_timer.timeout.connect(on_recharge_timer_timeout)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


# handle stopwatch
	if Gamelogic.stopwatch == true:
		sec = snapped(Gamelogic.calctime,0.01) - (minsub * 60)
		stopwatch.text = str(minutes," : ", sec)
		if sec > 60:
			sec = sec -60
			minutes += 1
			minsub += 1


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
				jump.play()
				delay.start()
				dashcheck()

		elif Input.is_action_just_pressed("Dash") and Dashing.Dashcounter > 0:
			Dashing.dash = true
			velocity.y = JUMP_VELOCITY+150
			for i in range(6):
				Dashing.SPEED += 100
			Dashing.Dashcounter -= 1
			print(Dashing.Dashcounter)
			jump.play()
			delay.start()
			dashcheck()
	
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right") and is_on_floor():
		running.play()
	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right"):
		running.stop()
	
	
	timeleft = snapped(Dash_timer.time_left, 0.1)
	dashes.text = str(Dashing.Dashcounter)
	time.text = str(timeleft)
	move_and_slide()
	#print(dashing.SPEED)
	#print(dashing.dash)
	#print(delay.time_left)
	#print(is_on_floor())
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
