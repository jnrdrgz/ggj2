extends KinematicBody

var patente
var rng = RandomNumberGenerator.new()

export var gravity : float = 100
export var speed : float = 7
export var acceleration : float = 3
var velocity : Vector3

func rand_pat_lets():
	var chars = ""
	var abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	for i in range(3):
		chars += abc[rng.randi_range(0,len(abc)-1)]
	
	return chars

func random_patente():
	var num = rng.randi_range(100,999)
		
	return rand_pat_lets() + "-" + str(num)

func _physics_process(delta):
	var direction = Vector3()
	direction = direction.normalized()

	var accel = acceleration
	velocity = velocity.linear_interpolate(direction * speed, accel * delta)
	
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)

	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)

func _ready():
	rng.randomize()
	patente = random_patente()
	$CanvasL/Patente.text = patente	

func _on_sedan_mouse_entered():
	var pat = $CanvasL/Patente
	pat.visible = true
	pat.set_global_position(get_viewport().get_mouse_position()) 
	
func _on_sedan_mouse_exited():
	$CanvasL/Patente.visible = false	
