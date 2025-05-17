extends Camera3D

@onready var camera_3d: Camera3D = $"."


@onready var character_body: CharacterBody3D = $".."




func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _process(_delta: float) -> void:
	_input(InputEventMouseMotion)
	
	
	
	if Input.is_action_just_pressed("REMOVELATER"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



var LOOKAROUND_SPEED = 0.005
var rot_x = 0
var rot_y = 0

func _input(event):
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		rot_x += (event.relative.x * LOOKAROUND_SPEED) * -1
		rot_y += (event.relative.y * LOOKAROUND_SPEED) * -1 # *-1 is used to uninvert camera 
		transform.basis = Basis() # reset rotation
		rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in X
		rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in Y
