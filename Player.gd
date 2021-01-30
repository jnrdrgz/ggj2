extends KinematicBody

var velocity = Vector3(0,0,0)
var SPEED = 2
var GRAVITY = 9.8

export (int) var speed = 100 
export (int) var gravity = 100

enum {FACING_BACK, FACING_FORW}

var facing = FACING_FORW

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

	#if Input.is_action_pressed("move_right"):
	#	velocity.x = -SPEED
	#if Input.is_action_pressed("move_left"):
	#	velocity.x = SPEED
	if Input.is_action_pressed("move_right"):
		if facing == FACING_FORW:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
	if Input.is_action_pressed("move_left"):
		if facing == FACING_FORW:
			velocity.x = -SPEED
		else:
			velocity.x = SPEED

	if Input.is_action_pressed("move_forward"):
		velocity.z = -SPEED
		
		var n = 1.631
		var v = get_node("FollowNode").transform.origin
		if not facing == FACING_FORW:
			facing = FACING_FORW
			get_node("FollowNode").transform.origin.z += n*2
			get_node("FollowNode").rotation_degrees = Vector3(0,0,0)
			get_parent().get_node("InterpolatedCamera").transform = get_node("FollowNode").transform
			
	if Input.is_action_pressed("move_backward"):
		velocity.z = SPEED
		var n = 1.631
		var v = get_node("FollowNode").transform.origin
		if not facing == FACING_BACK:
			facing = FACING_BACK
			get_node("FollowNode").transform.origin.z -= n*2
			get_node("FollowNode").rotation_degrees = Vector3(0,180,0)
			get_parent().get_node("InterpolatedCamera").transform = get_node("FollowNode").transform
			#get_parent().get_node("InterpolatedCamera").rotate(180)
		

func _physics_process(delta):
	get_input()
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)

	move_and_slide(velocity)
