extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D

const SPEED = 7
const JUMP_VELOCITY = 7

var LOOKAROUND_SPEED = 0.005
var rot_x = 0
var rot_y = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		rot_x += (event.relative.x * LOOKAROUND_SPEED) * -1
		rot_y += (event.relative.y * LOOKAROUND_SPEED) * -1 # *-1 is used to uninvert camera
		
		rot_y = clamp(rot_y, deg_to_rad(-89), deg_to_rad(89)) #stops rot_y from going past -89 and 89 degrees 
		
		transform.basis = Basis() # reset rotation
			
		rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in X
		rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in Y


func _process(delta: float) -> void:
	_input(InputEventMouseMotion)
	




	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta # while not on floor, velocity is added up by gravity multiplied by time since last frame

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("Strafe left", "Strafe right", "Walk forward", "Walk backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
