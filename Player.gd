extends KinematicBody

export var speed : float = 2
export var acceleration : float = 2
export var air_acceleration : float = 5
export var gravity : float = 100
export var max_terminal_velocity : float = 54
export var jump_power : float = 20

export(float, 0.1, 1) var mouse_sensitivity : float = 0.2
export(float, -90, 0) var min_pitch : float = -90
export(float, 0, 90) var max_pitch : float = 90

var velocity : Vector3
var y_velocity : float

onready var camera_pivot = $CameraPivot
onready var camera = $CameraPivot/SpringArm/Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x*mouse_sensitivity
		camera_pivot.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, min_pitch, max_pitch)

func _physics_process(delta):
	handle_movement(delta)
	
func handle_movement(delta):
	var direction = Vector3()
	
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	
	if Input.is_action_pressed("move_right"):
		direction += transform.basis.x
		
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
		
	if Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	
	direction = direction.normalized()

	var accel = acceleration
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
