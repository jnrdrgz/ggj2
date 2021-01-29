extends KinematicBody

var velocity = Vector3(0,0,0)
var SPEED = 2
var GRAVITY = 9.8

export (int) var speed = 100 
export (int) var gravity = 100

var jumping = false

func get_input():
	velocity.x = 0
	velocity.z = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("ui_up"):
		velocity.z = -SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.z = SPEED

func _physics_process(delta):
	get_input()
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)

	move_and_slide(velocity)